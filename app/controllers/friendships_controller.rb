# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def send_friend_request
    user = User.find(params[:user_id])
    if !current_user.send_friend_request(user).nil?
      flash[:success] = 'You sent a friend request'
    else
      flash[:danger] = 'Not a valid invitation'
    end
    redirect_to users_path
  end

  def cancel_friend_request
    user = User.find(params[:invited_id])
    user.friend_requests.where(requestor_id: current_user.id).delete_all
    flash[:danger] = 'Invitation destroyed'
    redirect_to users_path
  end

  def accept_friend
    @friend = User.find(params[:friend_o])
    current_user.accept_friend_request(@friend)
    redirect_to users_path
  end

  def delete_friend
    @user = User.find(params[:friend_d])
    current_user.unfriend(@user)
    redirect_to users_path
  end

  def friend_requests
    current_user.pending_requests
  end
end
