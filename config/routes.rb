Rails.application.routes.draw do

  # ============ devise ==============
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  # ============ home.controller ==============
  root 'home#index'
  get ":id/enters" => "home#enters"
  get ":post_id/fcshow" => "home#show"
  get ":id/edit_profile" => "home#edit_profile"
  get "account/:id/edit" => "home#edit_account"
  post "user/:id/update" => "home#update_user"
  get "user/:id/fc_list" => "home#fc_list"
  get "others" => "home#others"
  get "policy_law" => "home#policy_law"
  get "home/:id/likes" => "home#likes"
  get "home/new_fc" => "home#new_fc"
  post "home/create" => "home#create"
  get "home/profile/:id" => "home#profile"
  get ":id/show_fc" => "home#show_fc"
  get ":id/edit_fc" => "home#edit_fc"
  post ":id/update_fc" => "home#update_fc"
  post ":id/fc/destroy" => "home#destroy"
  get ":id/setting" => "home#setting"
  get "home/new_fc_content" => "home#new_fc_content"
  post "home/content_create" => "home#content_create"

  # ============ fc_content.controller ==============
  get 'fc_contents/index/:id' => "fc_contents#index"
  get "fc_contents/new/:id" => "fc_contents#new"
  get "fc_content/:id" => "fc_contents#show"
  post "fc_content/create/:id" => "fc_contents#create"


  post "enter/:id/create" => "enters#create"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "pay" => "pay#payment"

end
