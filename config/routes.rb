Rails.application.routes.draw do
  root 'home#index'

  resources :employees do
    collection do
      post :import
    end
  end

  resources :chat_transcripts, only: [:index, :show] do
    collection do
      get 'import' # For displaying the import form
      post 'import' # For handling the CSV file upload
    end
  end

  namespace :api do
    namespace :v1 do
      resources :employees do
        collection do
          post :import
        end
      end
    end
  end
end
