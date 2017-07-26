Rails.application.routes.draw do
  resources :students do
    resources :scores
  end
end
