Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :portfolio_3 do
    root 'home#top'
    get '/like', to: 'home#like'
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
    }
    resources :categories
    resources :posts
    resources :completes do
      resource :likes, only: [:create, :destroy]
    end
  end
end
