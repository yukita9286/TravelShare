Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  root to: 'homes#top'
  get 'homes/about' => 'homes#about'

  # ゲスト
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  # 会員
  scope module: :public do
    
  get '/search', to: 'searchs#search'
  get 'customers/confirm' => "customers#confirm"
  patch 'customers/out' => "customers#out"
  resources :customers, only: [:index, :show, :edit, :update] do
      member do
    # いいねした一覧
    get :liked_posts
    end

    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"

  end

  resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do

    resource :favorites, only: [:create, :destroy]
    
    resources :post_comments, only: [:create, :destroy]

  end

  end



  #管理者
  namespace :admin do
  root to: 'customers#index'
  patch 'customers/:id/out' => 'customers#out', as: 'customers_out'
  resources :customers, only: [:index, :show]
  resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do


    resources :post_comments, only: [:destroy]

  end

  end

end
