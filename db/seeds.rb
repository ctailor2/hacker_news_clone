require 'faker'

5.times do
  user = User.create(username: Faker::Internet.user_name, password: Faker::Name.first_name, email: Faker::Internet.email)
  5.times do
    post = user.posts.create(title: Faker::Company.catch_phrase, url: "http://www.google.com")
    5.times do
      post.comments.create(text: Faker::Company.bs)
    end
  end
end
