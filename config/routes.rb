Rails.application.routes.draw do

  #ruta para la vista de editar el color de las priodades
  resources :priorities, only: [:index, :edit, :update]

  #ruta de inicio
  resources :home, only: [:index, :show]

  #definir ruta de inicio
  root 'home#index'
  
  #ruta de tickets, los cuales tiene un estado y contienen comentarios
  resources :tickets do
    resources :comments, only: [:create, :update, :destroy]   
    resources :statuses, only: [:update]
  end

  #rutas para cambiar los valores a al ticket
  get "tickets/:id/proceso" => "tickets#proceso"
  get "tickets/:id/finalized" => "tickets#finalized"
  get "tickets/:id/morePrio" => "tickets#morePrio"
  get "tickets/:id/lessPrio" => "tickets#lessPrio"
  get "tickets/:id/upgrade" => "tickets#upgrade"

  #ruta para el admin panel
  ActiveAdmin.routes(self)

  #ruta para el login
  devise_for :users, skip: [:registrations] 

end