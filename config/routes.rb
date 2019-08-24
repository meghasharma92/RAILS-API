Rails.application.routes.draw do
  
  devise_for :users
  
  namespace :v1, defaults: {format: :json} do
  	devise_scope :user do
  		post 'signup', to: 'registrations#create'
  		post 'sign_in', to: 'sessions#create'
  		delete 'sign_out', to: 'sessions#destroy'
  		resources :books, only: [:index, :show] do
  			resources :reviews
  		end

  	end
  end

end
