require 'net/ftp'



class UsersController < ApplicationController
	http_basic_authenticate_with :name => "root", :password => "secret", :except => [:new, :show, :edit, :create, :delete_file]
	def index
		@user = User.all
	end

	def destroy
		@user = User.all
		@user = User.find(params[:id])
	  	@user.destroy
	  	redirect_to :action => :index
	  	#redirect_to :action => :refreshDB 
    end

    def show
        if session[:user_id] == nil
            redirect_to :controller => :welcome 
        else
    	@user = User.find(session[:user_id])
    	@email = @user[:email]
        ftp = Net::FTP.new('pegas.beget.ru')
        ftp.passive = true
        ftp.login(user = "melnik5g_andrey", passwd="DENVER")
    	ftp.chdir "/files/#{@email}"
		@files = ftp.nlst('*')
        end
    end

    def delete_file
        @user = User.find(session[:user_id])
        @email = @user[:email]
        ftp = Net::FTP.new('pegas.beget.ru')
        ftp.passive = true
        ftp.login(user = "melnik5g_andrey", passwd="DENVER")
        ftp.chdir "/files/#{@email}"
        ftp.delete(params[:name])
        redirect_to(:back)
    end

end