Rails.application.routes.draw do
  root 'leads#index'

  concern :noteable do
    resources :notes
  end

  scope module: :api do
    scope module: :v1 do
      resources :clients, concerns: :noteable do
        resources :projects, controller: 'client_projects'
      end
      resources :leads do
        concerns :noteable
      end
      resources :projects, concerns: :noteable do
        resources :invoices, concerns: :noteable
        resources :log_hours, concerns: :noteable
        resources :milestones, concerns: :noteable
        resources :resources, controller: 'project_resources'
      end
      resources :resources, concerns: :noteable
    end
  end
end
