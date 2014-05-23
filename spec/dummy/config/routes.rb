Rails.application.routes.draw do

  mount Caboose::Engine => "/"
  match '*path' => 'caboose/pages#show'
end
