Rails.application.routes.draw do
  resources :widgets

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'
  get  'jerks'=>'handler#jerks'
  get  'wisdom'=>'handler#any_jerk'
  get  'jerk/:name'=>'handler#jerk_sez'
  get  'jerk/:name/:rows'=>'handler#jerk_sez'
  get  'sparkling_conversation/:id'=>'handler#discourse'
  get  'sparkling_conversation' => 'handler#random_discourse'
  get  'sparkling_conversation/:count'=>'handler#random_discourse'
  get  'search/:q'=>'handler#search'
  get  'search/:q/:page'=>'handler#search'

end
