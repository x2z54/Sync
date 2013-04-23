#!/bin/env ruby
# encoding: utf-8
require 'net/ftp'
require 'open-uri'

class FilesController < ApplicationController
	def index
		if session[:user_id] == nil
            redirect_to :controller => :welcome 
        else
    	@user = User.find(session[:user_id])
    	@email = @user[:email]
        if connect
    	   @ftp.chdir "/files/#{@email}"
           begin
           @files = @ftp.nlst("*")
           rescue
           @files = @ftp.nlst(dir=nil)
           end
        end
        end
	end

    def connect
        @ftp = Net::FTP.new("fluorine.locum.ru")
        @ftp.passive = true
        @ftp.login(user = "hosting_x2z54", passwd="zI6t73mh")
    end

	def delete_file
        @user = User.find(session[:user_id])
        @email = @user[:email]
        if connect
            @ftp.chdir "/files/#{@email}"
            begin
            @ftp.delete(params[:name])
            rescue Net::FTPPermError
            @ftp.rmdir(params[:name])
        end
            redirect_to(:back)
        end
    end

    def download_file
        @user = User.find(session[:user_id])
        @email = @user[:email]
            filename = params[:name]
            File.open("#{Rails.public_path}/Files/#{@email}/#{File.basename(params[:name])}" ,'wb') {|f|f.write(open("ftp://hosting_x2z54:zI6t73mh@fluorine.locum.ru/files/#{@email}/#{params[:name]}").read)}
            send_file("#{Rails.public_path}/Files/#{@email}/#{File.basename(params[:name])}")
    end


end
