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

    post '/breweries/:id' do
        @brewery = Brewery.find_by(id: params[:visit][:brewery_id])
        @user = User.find_by(id: params[:visit][:user_id])
        if is_logged_in?
            if @user.id == current_user.id
                Visit.where(user_id: @user.id, brewery_id: @brewery.id).first_or_create
                redirect "/passport/#{@user.id}"
            else
                redirect "/breweries"
            end
        else
            redirect '/login'
        end
    end

    delete '/breweries/:id' do
        @brewery = Brewery.find_by(id: params[:visit][:brewery_id])
        @user = User.find_by(id: params[:visit][:user_id])
        if is_logged_in?
            if @user.id == current_user.id
                visit = Visit.find_by(user_id: @user.id, brewery_id: @brewery.id)
                visit.delete
                redirect "/passport/#{@user.id}"
            else
                redirect '/breweries'
            end
        else
            redirect '/login'
        end
    end

end