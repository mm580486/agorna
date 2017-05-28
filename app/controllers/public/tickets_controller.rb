class Public::TicketsController < ApplicationController
  layout 'public'
  before_action :user_login
  def index
    @tickets=Ticket.where('user_id = ? OR user_two = ?',current_user.id,current_user.id)
  end

  def new
    @ticket=Ticket.new(user_two: params[:id])
  end
  
  def create
    @ticket=Ticket.new(ticket_white_list)
    @ticket.user_id=current_user.id
    @ticket.user_two=params[:ticket][:user_two]
    @ticket.ticketmessages
    @ticket.save
    redirect_to  conversation_public_ticket_path(id: @ticket.id)
  end
  
  def conversation
    @ticket=Ticket.find(params[:id])
    
  end
  
  def save_conversation
    @ticket=Ticket.find(params[:id]).ticketmessages.build(ticketmessages_white_list)
    @ticket.user_id=current_user.id
    @ticket.save
    redirect_to :back
  end

  def show
  end
  
    private
def ticket_white_list
  params.require(:ticket).permit(:title,:user_id, :user_two,ticketmessages_attributes: [:user_two,:id,:user_id,:message,:ticket_id])
end
def ticketmessages_white_list
  
  params.require(:ticketmessage).permit(:message)
end
end
