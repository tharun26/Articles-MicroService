FactoryBot.define do
  sequence :slug do |n|
    "article-#{n}"
  end

  factory :article do
    title { "Sample article" }
    content { "Sample content" }
    slug { generate(:slug) }
  end
end
