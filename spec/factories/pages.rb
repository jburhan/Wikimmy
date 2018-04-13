include RandomData

FactoryGirl.define do

  factory :page do
    title RandomData.random_sentence
    body  RandomData.random_paragraph
    user
  end

end
