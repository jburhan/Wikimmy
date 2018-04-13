5.times do
  User.create!(
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all


50.times do
  page = Page.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_page,
    user: users.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Page.count} wikis created"
