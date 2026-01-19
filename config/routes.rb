Rails.application.routes.draw do
  devise_for :users
  
  # Root path - dashboard for logged in users
  root "dashboard#index"
  
  # Dashboard
  get "dashboard", to: "dashboard#index", as: :dashboard
  
  # Groups
  resources :groups do
    resources :seasons, only: [ :index, :new, :create, :show ]
    member do
      get :invite
    end
  end
  
  # Invite flow
  get "join/:invite_code", to: "invites#show", as: :join
  post "join/:invite_code", to: "invites#accept", as: :accept_invite
  
  # Seasons nested under groups (additional routes)
  resources :seasons, only: [] do
    resources :weeks, only: [ :index, :show ]
  end
  
  # Weeks
  resources :weeks, only: [] do
    resources :submissions, only: [ :index, :new, :create, :show ]
  end
  
  # Votes
  resources :submissions, only: [] do
    resources :votes, only: [ :create ]
  end
  
  # Leaderboards
  resources :groups, only: [] do
    get "leaderboard/weekly/:week_id", to: "leaderboards#weekly", as: :weekly_leaderboard
    get "leaderboard/season/:season_id", to: "leaderboards#season", as: :season_leaderboard
    get "leaderboard/all_time", to: "leaderboards#all_time", as: :all_time_leaderboard
  end
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # PWA files
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
