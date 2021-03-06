Rails.application.routes.draw do


  devise_for :doctors
  devise_for :patients
  get "/patient/auth/:provider/callback" => "authentications#google_oauth2"
  get "/doctor/auth/:provider/callback" => "authentications#google_oauth2"
  get "/doctor/auth/:provider" => "authentications#google_oauth2", as: 'google_oauth2_doctor'
  get "/patient/auth/:provider" => "authentications#google_oauth2", as: 'google_oauth2_patient'

  root "application#index"
  resources :patients, only: [:index, :show] do
    collection do
      get 'patient' => 'patients#omniauth', as: 'p_omniauth'
    end
    member do
      post '/eta' => 'patients#eta', as: 'eta'
      get '/find_appointments' => 'patients#find_appointments',as: :'find_appointments'
    end
  end
  resources :doctors, only: [:index, :show] do
    collection do
      get 'doctor' => 'doctors#omniauth', as: 'd_omniauth'
    end
    member do
      get '/get_patient' => 'doctors#get_patient', as: 'get_patient'
      post '/send_appointment' => 'doctors#send_appointment',as: 'send_appointment'
      post '/find_patient/:patient_id' => 'doctors#find_patient', as: 'find_patient'
    end
  end

  # The priority is based upon order of creatio first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
