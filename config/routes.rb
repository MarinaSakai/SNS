Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  resources :users, :only => [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    collection do
      get "follows" => "posts#follows"
    end
  end

end
