Rails.application.routes.draw do
  scope :v1, module: :v1, defaults: { format: :json } do
    specify :users
    specify :articles
    scope module: :padlock do
      specify :registrations
      specify :sessions
    end
  end

  scope :v2, module: :v2 do
    scope :admin, module: :admin do
      specify :articles
    end
  end

  specify :articles
end
