Rails.application.routes.draw do
  get "/" => "top#top"
  get 'users/show'
  devise_for :users

  resources :users, :only => [:show, :edit, :update] do
    resources :follows, controller:'follows', except: [:index, :new, :edit, :show, :update]
    member do
      get "index_following" => "follows#index_following"
      get "index_followers" => "follows#index_followers"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :favs_posts, controller:'posts/favs_posts', except: [:index, :new, :edit, :show, :update]
    resources :comments, controller:'posts/comments' do
      resources :favs_comments, controller:'comments/favs_comments', except: [:index, :new, :edit, :show, :update]
    end
    collection do
      get "follows" => "posts#follows"
    end
  end
  
end
