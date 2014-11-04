# encoding: utf-8

FactoryGirl.define do
  factory :bonus do
    city
    title do
      [
        'Скидка 30% на «Автохуйло73»',
        'Скидка 20% на ремонт автостекла в «Автостекло73»',
        'Скидка в магазине «Симтранс» до 30%'
      ].sample
    end
    description { generate :markdown_text }
  end
end
