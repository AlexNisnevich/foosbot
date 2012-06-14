Foosbot::Application.routes.draw do
  resources :games, :only => %w{index new create show}

  resources :players do
    member do
      match :photo
    end
  end
end
