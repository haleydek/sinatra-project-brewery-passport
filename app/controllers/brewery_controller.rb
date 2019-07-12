class BreweryController < ApplicationController
    get '/breweries' do
        @user = current_user
        if is_logged_in?
            erb :'/breweries/index'
        else
            redirect '/login'
        end
    end

    get '/breweries/:id' do
        @brewery = Brewery.find(params[:id])
        @user = current_user
        if is_logged_in?
            erb :'/breweries/show'
        else
            redirect '/login'
        end
    # change route to slug for brewery name
    end

end