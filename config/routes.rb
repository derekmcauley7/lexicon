Rails.application.routes.draw do

  root :to =>  'search#index'

  get 'show/:word', :to => 'search#found', :as => 'found_word'

  get 'search/index'
  get 'search/found'
  get 'search/notFound'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
