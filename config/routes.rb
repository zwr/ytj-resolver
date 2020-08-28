Rails.application.routes.draw do
  get 'find/:ytunnus', to: 'ytj#index'
end
