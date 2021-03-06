EventCoordinator::Application.routes.draw do
  root :to => "home#index"

  #devise_for :users
  devise_for :users, :controllers => { :registrations =>'registrations' }
  resources :users, :only => :show

  resources :main_events do
    resources :events, :as => :event
  end
  get "main_events/:main_event_id/calender" => "calendar#index", :as => :calendar
  get "main_events/:main_event_id/calender/events" => "calendar#events", :as => :calendar_events
  get "events/:id/sign_up" => "events#sign_up", :as => :sign_up_for_event
  get "events/:id/unregister" => "events#unregister", :as => :unregister_from_event
  
  get "events/:id/workers/search" => "event_workers#show", as: :search_workers
  get "events/:id/workers" => "event_workers#index", as: :workers_for_shift
  put "events/:id/workers/:worker_id" => "event_workers#update", as: :add_event_worker
  delete "events/:id/workers/:worker_id" => "event_workers#destroy", as: :remove_worker_from_shift

  get "main_events/:id/register" => "main_events#register", :as => :register_for_main_event
  get "main_events/:id/unregister" => "main_events#unregister", :as => :unregister_for_main_event

  get "main_events/:id/admin" => "admin#index", :as => :admin_main_event

  #oauth
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'
  resources :authentications
  #google auth site verification
  match '/google1a1eff988923f33a', :to => redirect('/google1a1eff988923f33a.html')

  get "events/:main_event_id/shifts_pdf" => "shifts_pdf#index", :as => :shifts_pdf

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end

  #get "main_events/:main_event_id/events" => "events#index", :as => :events
  #post "main_events/:main_event_id/events" => "events#create", :as => :create_event

  #get "main_events/:main_event_id/event/new" => "events#new", :as => :new_event
  #get "main_events/:main_event_id/event/:id/edit" => "events#edit", :as => :edit_event
  #get "main_events/:main_event_id/event/:id(.:format)" => "events#show", :as => :event
  #put "main_events/:main_event_id/event/:id" => "events#update"
  #delete "main_events/:main_event_id/event/:id" => "events#destroy"




  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
