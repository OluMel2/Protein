Rails.application.routes.draw do


    #get 'users/show'
    #get 'users/edit'
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }

  #顧客側
  scope module: :public do
    root to:'homes#top'
    get 'about' => 'homes#about'

    get 'posts/all' => 'posts#index'
    #get 'posts/information/edit' => 'posts#edit'


    resource :user, only: [:update]
    get 'users/mypage/:id' => 'users#show', as: 'user_mypage'
    get 'users/information/edit/:id' => 'users#edit', as: 'user_information'
    get 'users/quit' => 'users#quit'
    patch 'users/out' => 'users#out'

    resources :posts, only: [:show, :new, :create, :update, :edit, :destroy] do
      resources :comments, only: [:create, :destroy]
    end


  end


  #管理者側
  namespace :admin do

    root to:'homes#top'

    resources :posts, only: [:show, :destroy]

    resources :users, only: [:index, :show, :edit, :update] do
      resources :comments, only: [:destroy]
    end

    resources :tags, only: [:index, :create, :edit, :update]

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
