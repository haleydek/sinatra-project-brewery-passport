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
        @brewery = Brewery.find_by(id: params[:id])
        @user = current_user
        if is_logged_in?
            erb :'/breweries/show'
        else
            redirect '/login'
        end
    # change route to slug for brewery name
    end

    post '/create-visit' do
        brewery = Brewery.find_by(id: params[:visit][:brewery_id])
        user = User.find_by(id: params[:visit][:user_id])
        if is_logged_in?
            if user.id == current_user.id
                Visit.where(user_id: user.id, brewery_id: brewery.id).first_or_create
                redirect "/passport/#{current_user.id}"
            else
                redirect "/breweries"
                #flash message that they can only edit their own passport
            end
        else
            redirect '/login'
        end
    end

end