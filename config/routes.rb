Rails.application.routes.draw do
  scope :v1, module: :v1, defaults: { format: :json } do
    specify :articles
  end
end
