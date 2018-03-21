Rails.application.routes.draw do
  scope :spacewalk, module: 'foreman_spacewalk' do
    constraints(id: %r{[^\/]+}) do
      resources :hosts, only: [] do
        collection do
          post :select_multiple_spacewalk_proxy
          post :update_multiple_spacewalk_proxy
        end
      end
    end
  end
end
