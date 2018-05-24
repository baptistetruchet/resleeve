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
      redirect_to conversation_path(@conversation)
    else
      redirect_to conversation_path(@conversation)
      flash[:alert] = "#{@message.errors.full_messages}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
