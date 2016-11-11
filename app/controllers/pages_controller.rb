class PagesController < ApplicationController
    def home
        redirect_to properties_path if logged_in?
    end
end