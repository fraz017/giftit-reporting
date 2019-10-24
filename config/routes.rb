Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :sub_admin, path: 'admins'
  root :to => "welcome#index"
end
