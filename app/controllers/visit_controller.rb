class VisitController < ApplicationController

    get '/create-passport' do
        @user = current_user
        if is_logged_in?
            if @user.breweries == []
                erb :'/visits/new'
            else
                redirect "/passport/#{current_user.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/passport/:user_id' do
        @user = User.find_by(id: params[:user_id])
        if is_logged_in?
            erb :'/visits/show'
        else
            redirect '/login'
        end
    end

    get '/passport/:user_id/edit' do
        @user = User.find_by(id: params[:user_id])
        if is_logged_in?
            if current_user.id == @user.id
                erb :'/visits/edit'
            else
                redirect '/breweries'
            end
        else
            redirect '/login'
        end
    end

    post '/create-passport' do
        if is_logged_in?
            params[:visit][:brewery_ids].each do |brewery_id|
                Visit.where(user_id: current_user.id, brewery_id: brewery_id).first_or_create
            end
            redirect "/passport/#{current_user.id}"
        else
            redirect '/login'
        end
    end

    patch '/passport/:user_id' do
        @user = User.find_by(id: params[:user_id])
        if is_logged_in?
            if current_user.id == @user.id
                params[:visit][:brewery_ids].each do |brewery_id|
                    Visit.where(user_id: @user.id, brewery_id: brewery_id).first_or_create
                end
                redirect "/passport/#{@user.id}"
            else
                redirect '/breweries'
            end
        else
            redirect '/login'
        end
    end

    delete '/passport/:user_id' do
        @user = User.find_by(id: params[:user_id])
        if is_logged_in?
            if current_user.id == @user.id
                params[:visit][:brewery_ids].each do |brewery_id|
                    visit = Visit.find_by(user_id: @user.id, brewery_id: brewery_id)
                    visit.delete
                end
                redirect "/passport/#{@user.id}"
            else
                redirect '/breweries'
            end
        else
            redirect '/login'
        end
    end
end