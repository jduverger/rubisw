class AdminController < ApplicationController
  def index
    lname = session[:lname]
    return if lname

    session[:backafterreg] = '/admin'
    redirect_to login_path
    nil
  end
end
