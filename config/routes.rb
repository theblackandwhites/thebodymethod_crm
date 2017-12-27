Rails.application.routes.draw do
  
  


  get 'dashboard/client_aquisition'

  get 'dashboard/analytics'

  get 'dashboard/schedual'

#Resource Routes
  

  resources :profiles do
    get 'pay_online_only' => 'profiles#pay_online_only'
  end 

  resources :bookables do
    get 'confirm_booking' => 'participants#confirm_booking'
    get 'booking_confirmation' => 'participants#booking_confirmation'
    get 'pay_with_points' => 'points#pay_with_points'
    get 'create_customer' => 'charge#create_customer'
    get 'create_customer_points' => 'charge#create_customer_points'
    get 'create_charge' => 'charge#create_charge'
    get 'create_charge_points' => 'charge#create_charge_points'
    get 'add_to_waitlist' => 'participants#add_to_waitlist'
    get 'waiting_list_confirmation' => 'participants#waiting_list_confirmation'
    get 'cancel_booking' => 'participants#cancel_booking'
    get 'checkin' => 'bookings#checkin'
    get 'post_checkin' => 'bookings#post_checkin'
    get 'close_booking_screen' => 'bookings#close_booking_screen'
    get 'close_participant' => 'bookings#close_participant'
    get 'close_booking' => 'bookings#close_booking'
    post 'walkin_booking' => 'participants#walkin_booking'
  end

  resources :packages do
    get 'subscribe_user' => 'packages#subscribe_user'
    get 'subscription_confirmation' => 'packages#subscription_confirmation'
  end

  resources :bookable_types
  resources :qualifications
  resources :instructors

  resources :locations do
    resources :enquries
  end

  resources :debts do
    post 'pay_debt' => 'debts#pay_debt'
  end

  #devise
  devise_for :users, controllers: { registrations: "registrations" }

  #Custom Routes
    #static pages
    get 'static/home'

    #Charges
    get 'my_charges' => 'charge#my_charges'
    get 'edit_charge' => 'charge#edit_charge'
    patch 'update_charge' => 'charge#update_charge'
    
    #Bookings
    get 'my_bookings' => 'bookings#my_bookings'

    #Points
    get 'new_points' => 'points#new_points'
    post 'create_points' => 'points#create_points'
    get 'remove_points' => 'points#remove_points'
    post 'delete_points' => 'points#delete_points'

    #Reconcile
    get 'reconcile' => 'reconciliation#reconcile'
    get 'reconcile_bookable' => 'reconciliation#reconcile_bookable'

    #participants
    get 'bookable_participants' => 'participants#bookable_participants'

  # Root Path
  root to: "static#home"

  #For Cloudinary and Attachinary
  mount Attachinary::Engine => "/attachinary"

end
