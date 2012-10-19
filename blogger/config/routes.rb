Blogger::Application.routes.draw do
  resources :authors
  resources :author_sessions

  get "tags/index"

  get "tags/show"

  resources :articles
  resources :comments
  resources :tags

  root :to => 'articles#index'

	match 'login'  => 'author_sessions#new',     :as => :login
	match 'logout' => 'author_sessions#destroy', :as => :logout

end