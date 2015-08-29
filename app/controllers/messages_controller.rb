class MessagesController < ApplicationController
	before_action :find_message, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authorized_user, only: [:edit, :update, :destroy]
	
	
	def index
		@messages = Message.all.order("created_at DESC")
		if params[:search]
         		@messages = Message.search(params[:search]).order("created_at DESC")
        	end
	
	if params[:tag]
    	@messages = Message.tagged_with(params[:tag])
  	end
	
	end



	def show
	end

	def new
		@message = current_user.messages.build
	end

	def create
		@message = current_user.messages.build(message_params)
		if @message.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @message.update(message_params)
			redirect_to message_path
		else
			render 'edit'
		end
	end

	def destroy
		@message.destroy
		redirect_to root_path
	end

	private
		def message_params
			params.require(:message).permit(:title, :description, :avatar, :tag_list)
		end

		def find_message
			@message = Message.find(params[:id])
		end
		
	def authorized_user
      		@message = current_user.messages.find_by(id: params[:id])
      		redirect_to root_path, notice: "Not authorized to edit this link" if @message.nil?
    	end
    	
	
end
