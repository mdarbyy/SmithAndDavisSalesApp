Rails.application.routes.draw do
  resources :sales_records
  resources :sales_people
  get 'static_pages/dashboard', to: 'static_pages#dashboard', as: 'dashboard'
  root "static_pages#dashboard"
end