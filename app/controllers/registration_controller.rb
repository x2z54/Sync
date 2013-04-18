require "fileutils"
require "pathname"
require 'net/ftp'

BD_PATH = "/home/andrew/Dropbox/Rails/site/db/development.sqlite3"


class RegistrationController < ApplicationController
	def index	
	end

	def create	
		@user = User.new(params[:user])
		if @user.save
		render "_good"
		else
		render "_error_messages"
		end
	end

	def download
		send_file "#{Rails.public_path}/test.zip", :type=>"application/zip"
	end

	def refreshDB
    	ftp = Net::FTP.new('pegas.beget.ru')
    	ftp.passive = true
    	ftp.login(user = "melnik5g_andrey", passwd="DENVER")
    	files = ftp.chdir('/db')
    	ftp.putbinaryfile(BD_PATH, remotefile = File.basename(BD_PATH), 1024)
    	ftp.quit()
    	render "_good"
    end

end
