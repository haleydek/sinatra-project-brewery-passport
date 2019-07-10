class UserController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect '/breweries'
        else
            erb :signup
        end
    end

    post '/signup' do
        user = User.create(params[:id])
        session[:user_id] = user.id
        redirect '/'
   #    add slug for username in route
    end



end