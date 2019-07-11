class BreweryController < ApplicationController
    get '/breweries' do
        if is_logged_in?
            @breweries = Brewery.all
            erb :'/breweries/index'
        else
            redirect '/login'
        end
    end

    get '/breweries/:id' do
        @brewery = Brewery.find(params[:id])
        if is_logged_in?
            erb :'/breweries/show'
        else
            redirect '/login'
        end
    # change route to slug for brewery name
    end

end