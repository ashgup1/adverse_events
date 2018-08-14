Rails.application.routes.draw do
  # Routes for the Safety_event resource:
  # CREATE
  get "/safety_events/new", :controller => "safety_events", :action => "new"
  post "/create_safety_event", :controller => "safety_events", :action => "create"

  # READ
  get "/safety_events", :controller => "safety_events", :action => "index"
  get "/safety_events/:id", :controller => "safety_events", :action => "show"

  # UPDATE
  get "/safety_events/:id/edit", :controller => "safety_events", :action => "edit"
  post "/update_safety_event/:id", :controller => "safety_events", :action => "update"

  # DELETE
  get "/delete_safety_event/:id", :controller => "safety_events", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
