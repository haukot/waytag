# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user_name { generate :username }
    title
    content { generate :body }
    published_at { Time.now }
    seo_name { generate :slug }
    seo_keywords { generate :body }
    seo_description { generate :body }
  end
end
