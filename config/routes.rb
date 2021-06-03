Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      post 'ab_testing/variant_info'
      post 'ab_testing/signup_event'
      get 'ab_testing/test_results/:article_id'
    end
  end
end
