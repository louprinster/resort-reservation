ResortReservation::Application.routes.draw do

  get "/" => "main#root"
  get "/:reservation_category/intro"  => "main#intro_get"
  post "/:reservation_category/intro" => "main#intro_post"
  get "/your_reservation"             => "main#reservation_get"
  post "/your_reservation"            => "main#reservation_post"
  get "/add_reservation_item"         => "main#add_reservation_item_get"
  post "/add_reservation_item"        => "main#add_reservation_item_post"
  get "/guest_details"                => "main#guest_details_get"
  post "/guest_details"               => "main#guest_details_post"
  get "/review"                       => "main#review_get"
  post "/review"                      => "main#review_post"
  get "/modify_confirmed_reservation/:last_name/:confirmation_num" => "main#modify_confirmed_reservation_get",
    as: "modify_confirmed_reservation"
  post "/modify_confirmed_reservation" => "main#modify_confirmed_reservation_post"
  
  get "/contact"                      => "main#contact"
  
  
  resources :user, only: ["index", "new", "create"]
  post "/users/login"  => "user#login",  as: "login"
  post "/users/logout" => "user#logout", as: "logout"

  get "/verify_email/:user_id/:token" => "user#verify_email",
    as: "verify_email"
  post "/resend_verification_email" => "user#resend_verification_email",
    as: "resend_verification_email"

  get  "/users/forgot_password" => "user#forgot_password",
    as: "forgot_password"
  post "/users/forgot_password" => "user#forgot_password_post",
    as: "forgot_password_post"
  get  "/users/reset_password/:user_id/:token" => "user#reset_password",
    as: "reset_password"
  post "/users/reset_password" => "user#reset_password_post",
    as: "reset_password_post"


end

  # The priority is based upon order of creation: first created -> highest priority.
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
