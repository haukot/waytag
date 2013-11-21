# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user_name { generate :username }
    title {
      [
        "Приятное в офлайн!",
        "Проблема с антивирусом «Avast» при заходе на сайт",
        "Нововведения января",
        "Яндекс.виджет для Ульяновска и трансляция в формате RSS",
        "Первый пост, он главный самый"
      ].sample
    }
    content { generate :markdown_text }
    published_at { Time.now }
    seo_name { generate :slug }
    seo_keywords { generate :body }
    seo_description { generate :body }
  end
end
