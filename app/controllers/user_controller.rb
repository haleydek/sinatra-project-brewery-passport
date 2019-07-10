class UserController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect '/breweries'
        else
            erb :'/users/signup'
        end
    end

    get '/login' do
        if is_logged_in?
            redirect '/breweries'
        else
            erb :'/users/login'
        end
    end

    post '/signup' do
        user = User.create(params[:id])
        session[:user_id] = user.id
        redirect '/'
   #    add slug for username in route
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if is_logged_in?
            redirect '/breweries'
        elsif user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/breweries'
        else
            redirect '/login'
        end
    end

end