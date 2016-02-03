Rails.application.routes.draw do

  resources :priorities, only: [:index, :edit, :update]
  resources :home, only: [:index, :show]
  root 'home#index'
  get "tickets/:id/proceso" => "tickets#proceso"
  get "tickets/:id/finalized" => "tickets#finalized"
  get "tickets/:id/morePrio" => "tickets#morePrio"
  get "tickets/:id/lessPrio" => "tickets#lessPrio"
  get "tickets/:id/upgrade" => "tickets#upgrade"

  
  resources :tickets do
    resources :comments, only: [:create, :update, :destroy]   
    resources :statuses, only: [:update]
  end

  ActiveAdmin.routes(self)

  devise_for :users, skip: [:registrations] 
end