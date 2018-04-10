json.articles do
  json.array! @presenter.articles, partial: 'articles/article', as: :article
end

json.user @presenter.user
