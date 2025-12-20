Rails.application.routes.draw do
  root "dashboard#index"

  devise_for(
    :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    },
    path: 'users',
    path_names: { sign_in: 'sign_in', sign_out: 'sign_out' }
  )

  resources :users
  resources :sales_records
  resources :sales_people

  post 'admin/users', to: 'users#create', as: 'admin_create_user'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # Catch-all must ALWAYS be last
  get "/404", to: "errors#not_found"
  match "*unmatched", to: "errors#not_found", via: :all
end