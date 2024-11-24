class LoginController < ApplicationController
    def index
        # ok=smtp.set()
        @backafterreg=session[:backafterreg]
    end
    def check
        email=params[:email]
        pwd=params[:pwd]
        user = User.find_by(email: email)
        userpwd=user.pwd
        @backafterreg=session[:backafterreg]
        if userpwd = pwd
            session[:lname]=user.name
            redirect_to @backafterreg
            return
        end
        @errors="Email ou pwd erronés"
        redirect_to login_path
    end

    def logout
        backafterreg=session[:backafterreg]
        del request.session[:lname]
        redirect_to backafterreg
    end
end
