Rails.application.routes.draw do
  get 'profile/index'
	devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
      resources :profiles
  resources :recipes do
  	resources :reviews
  end
  root 'recipes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
