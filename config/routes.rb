Rails.application.routes.draw do
  get 'blocks/all' => 'blocks#index'
  post 'blocks/:id' => 'blocks#updateCoords'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
