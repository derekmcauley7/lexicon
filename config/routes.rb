Rails.application.routes.draw do

  resources :users, :except => [:show] do
    member do
      get :delete
    end
  end

  root :to =>  'search#index'

  get 'search/found', :as => 'found_word'

  get 'search/index'
  get 'search/found'
  get 'search/notFound'

end
