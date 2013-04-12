require 'net/ftp'

BD_PATH = "/home/andrew/Dropbox/Rails/site/db/development.sqlite3"

class UsersController < ApplicationController
	http_basic_authenticate_with :name => "root", :password => "secret", :except => [:new, :show, :edit, :create]
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
    	Dir.chdir "/home/andrew/Dropbox/Rails/site/public/files/#{@email}"
		@files = Dir.glob('*')
        end
    end

    def refreshDB
    	ftp = Net::FTP.new('pegas.beget.ru')
    	ftp.passive = true
    	ftp.login(user = "melnik5g_andrey", passwd="DENVER")
    	files = ftp.chdir('/db')
    	ftp.putbinaryfile(BD_PATH, remotefile = File.basename(BD_PATH), 1024)
    	ftp.quit()
    	redirect_to :action => :index
    end

end