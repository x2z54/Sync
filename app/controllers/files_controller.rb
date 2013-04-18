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
		   @files = @ftp.nlst('*')
        end
        end
	end

    def connect
        @ftp = Net::FTP.new('pegas.beget.ru')
        @ftp.passive = true
        @ftp.login(user = "melnik5g_andrey", passwd="DENVER")
    end

	def delete_file
        @user = User.find(session[:user_id])
        @email = @user[:email]
        if connect
            @ftp.chdir "/files/#{@email}"
            @ftp.delete(params[:name])
            redirect_to(:back)
        end
    end

    def download_file
        @user = User.find(session[:user_id])
        @email = @user[:email]
        if connect
            @ftp.chdir "/files/#{@email}"
            filename = params[:name]
            File.open("#{ENV['HOME']}/Загрузки/#{params[:name]}" ,'wb'){|f|f.write(open("ftp://melnik5g_andrey:DENVER@pegas.beget.ru/files/#{@email}/#{params[:name]}").read)}
            redirect_to(:back)
        end
    end
end
