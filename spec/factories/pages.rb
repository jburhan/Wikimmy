include RandomData

FactoryGirl.define do

  factory :page do
    title RandomData.random_sentence
    body  RandomData.random_page
    user
  end

end
