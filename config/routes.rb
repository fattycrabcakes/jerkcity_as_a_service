Rails.application.routes.draw do
  resources :widgets

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'
  get  'jerks'=>'handler#jerks'
  get  'jerks/any'=>'handler#any_jerk'
  get  'jerks/:name'=>'handler#jerk_sez'
  get  'jerks/:name/:rows'=>'handler#jerk_sez'
  get  'circlejerk/:id'=>'handler#discourse'
  get  'circlejerk/any' => 'handler#random_discourse'
  get  'circlejerk/any/:count'=>'handler#random_discourse'
  get  'search/:q'=>'handler#search'
  get  'search/:q/:page'=>'handler#search'
  get  'version'=>'handler#version'
  get  'operations'=>'handler#operations'
  put  '/ur/mouth'=>'handler#hurgleburgle'

end
