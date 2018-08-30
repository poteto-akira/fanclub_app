Rails.application.routes.draw do
get "home/test" => "home#barbajs"


  get ":id/edit_profile" => "home#edit_profile"
  get "account/:id/edit" => "home#edit_account"
  post "user/:id/update" => "home#update_user"
  get 'pay/payment'
  devise_for :users
  get "home/:id/likes" => "home#likes"
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  root 'home#index'
  get "home/new_fc" => "home#new_fc"
  post "home/create" => "home#create"
  get "home/profile/:id" => "home#profile"
  get ":id/show_fc" => "home#show_fc"
  get ":id/edit_fc" => "home#edit_fc"
  post ":id/update_fc" => "home#update_fc"
  post ":id/fc/destroy" => "home#destroy"
  get ":id/setting" => "home#setting"
  get "pay" => "pay#payment"
  get "home/new_fc_content" => "home#new_fc_content"
  post "home/content_create" => "home#content_create"
end
