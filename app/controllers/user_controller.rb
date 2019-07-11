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

    get '/logout' do
        if is_logged_in?
            session.clear
            redirect '/'
        else
            redirect '/breweries'
        end
    end

    post '/signup' do
        user = User.create(params["user"])
        session[:user_id] = user.id
        redirect '/create-passport'
    end

    post '/login' do
        user = User.find_by(email: params[:email])

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