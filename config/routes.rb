Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  resources :users, :only => [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments, controller:'posts/comments'
    resources :favs_posts, controller:'posts/favs_posts', except: [:index]
    collection do
      get "follows" => "posts#follows"
    end
  end

end
