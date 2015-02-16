Rails.application.routes.draw do
    devise_for :users, controllers: {registrations: 'registrations'}

    root "home#index"

    get 'dashboard' => 'dashboard#index'
    get 'dashboard/collect_information' => 'dashboard#collect_information'
    post 'dashboard/submit_information' => 'dashboard#submit_information'

    namespace :admin do
        get :analytics
        get :settings
    end
end
