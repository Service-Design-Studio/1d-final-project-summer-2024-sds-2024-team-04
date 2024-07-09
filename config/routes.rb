Rails.application.routes.draw do
  root 'home#index'
  resources :employees
  resources :chat_transcripts do
    collection do
      get 'import' # For displaying the import form
      post 'import' # For handling the CSV file upload
    end
  end
end