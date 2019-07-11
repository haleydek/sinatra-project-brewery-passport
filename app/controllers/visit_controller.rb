class VisitController < ApplicationController

    get '/create-passport' do
        @user = current_user
        if is_logged_in?
            erb :'/visits/new'
        else
            redirect '/login'
        end
    end

    get '/passport/:user_id'
        if is_logged_in? && current_user
            @user = current_user
            erb :'/visits/show'
        else
            redirect '/login'
        end
    end

    post '/create-passport' do
        params[:visit][:brewery_ids].each do |brewery_id|
            Visit.where(user_id: current_user.id, brewery_id: brewery_id).first_or_create
        end
        redirect "/passport/#{current_user.id}"
    end

end