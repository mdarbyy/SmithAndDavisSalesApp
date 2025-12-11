Rails.application.routes.draw do
  devise_for(
    :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    },
    path: 'users',
    path_names: { sign_in: 'sign_in', sign_out: 'sign_out' }
  )

  resources :users
  resources :sales_records
  resources :sales_people
  post 'admin/users', to: 'users#create', as: 'admin_create_user'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  
  root "dashboard#index"
end