Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :data_entries, only: [:create, :update] #Since created model with scaffold restricted to create and update onlyy as per requirement.
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
