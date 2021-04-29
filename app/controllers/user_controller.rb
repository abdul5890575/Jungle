class UserController < ApplicationController
    def new
    end

    def create
        user = User.new(user_params)
        if user.save
          session[:user_id] = user.id
          redirect_to '/'
        else
          redirect_to '/user/new'
        end
      end
    
      def user_params
        params.require(:user).permit(:Firstname, :Lastname, :email, :password, :password_confirmation)
      end
end
