Rails.application.routes.draw do
  get ':controller(/:action(/:id))'
  get ':controller(/:action)'
end
