class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :title, :content, :state, :published_at, :seo_name, :seo_keywords, :seo_description
end
