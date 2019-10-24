Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :sub_admin, path: 'admins'
  namespace :admin do
    get 'dashboard/:id' => 'dashboard#index'
    resource :sub_admins, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end
  end
  root :to => "welcome#index"
end
