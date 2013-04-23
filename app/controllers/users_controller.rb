#!/bin/env ruby
# encoding: utf-8
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
        end
    end

end