require "fileutils"
require "pathname"
require 'net/ftp'

class RegistrationController < ApplicationController
	def index	
	end

	def create	
		@user = User.new(params[:user])
		if @user.save
		Dir.mkdir "#{Rails.public_path}/Files/#{@user.email}"
		@ftp = Net::FTP.new("fluorine.locum.ru")
        @ftp.passive = true
        @ftp.login(user = "hosting_x2z54", passwd="zI6t73mh")
        @ftp.mkdir "/files/#{@user.email}"
		render "_good"
		else
		render "_error_messages"
		end
	end

	def download
		send_file "#{Rails.public_path}/syncapp.zip", :type=>"application/zip"
	end

end
