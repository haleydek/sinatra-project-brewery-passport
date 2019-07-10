class BreweryController < ApplicationController
    get '/breweries' do
        if is_logged_in?
            @user = current_user
            @breweries = Brewery.all
            erb :'/breweries/index'
        else
            redirect '/login'
        end
    end

end