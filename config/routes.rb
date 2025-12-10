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
  get 'static_pages/dashboard', to: 'static_pages#dashboard', as: 'dashboard'

  root "static_pages#dashboard"
end