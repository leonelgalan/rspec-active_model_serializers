Rails.application.routes.draw do
  namespace 'profiles' do
    %i(index show name_as_a_integer render_using_json_api
       invalid_json_body).each do |action|
       get action, as: action
    end
  end
end
