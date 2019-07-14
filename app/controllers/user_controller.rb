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

    get '/passport/:id' do
        @user = User.find_by(id: params[:id])
        if is_logged_in?
            if @user.id == current_user.id
                erb :'/users/show'
            else
                redirect '/breweries'
            end
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if is_logged_in?
            session.clear
            flash[:notice] = "Successfully logged out."
            redirect '/'
        else
            redirect '/breweries'
        end
    end

    post '/signup' do
        user = User.create(params["user"])
        if !user.valid?
            flash[:error] = user.errors.messages.values.join(" ")
            redirect '/signup'
        else
            session[:user_id] = user.id
            redirect '/breweries'
        end
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if is_logged_in?
            redirect '/breweries'
        elsif user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/breweries'
        else
            flash[:error] = "Incorrect username and/or password. Please try again."
            redirect '/login'
        end
    end

end