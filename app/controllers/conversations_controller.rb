class ConversationsController < ApplicationController
  def index
    @conversations = policy_scope(Conversation).select do |c|
      c.booking.owner == current_user || c.booking.renter == current_user
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end
end
