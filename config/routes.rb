Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/hello', to: 'portal_v1#hello'

      get '/idea', to: 'portal_v1#get_ideas'
      post '/idea/new', to: 'portal_v1#create_idea'
      post '/idea/delete', to: 'portal_v1#remove_idea'
      post '/idea/update', to: 'portal_v1#update_idea'
      post '/idea/pos/update', to: 'portal_v1#update_idea_pos'

      get '/bucket', to: 'portal_v1#get_buckets'
      post '/bucket/new', to: 'portal_v1#create_bucket'
      post '/bucket/delete', to: 'portal_v1#remove_bucket'
      post '/bucket/update', to: 'portal_v1#update_bucket'

    end
  end

end
