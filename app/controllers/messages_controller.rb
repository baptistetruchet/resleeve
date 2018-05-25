class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    authorize @message
    @conversation = Conversation.find(params[:conversation_id])
    @message.conversation = @conversation
    @message.sender = current_user
    book = @conversation.booking
    @message.receiver = book.owner == current_user ? book.renter : book.owner

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js  # <-- will render `app/views/messages/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'conversations/show' }
        format.js  # <-- idem
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
