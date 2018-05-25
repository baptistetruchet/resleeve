class ConversationsController < ApplicationController
  def index
    @conversations = policy_scope(Conversation).select do |c|
      c.booking.owner == current_user || c.booking.renter == current_user
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation

    #aller chercher les messages de la conversation
    messages = @conversation.messages
    #selectionner ceux dont je suis le receiver
    messages.each do |message|
      message.viewed = true if message.receiver == current_user
      message.save!
    end

    @message = Message.new
  end
end
