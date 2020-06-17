FactoryBot.define do
    factory :user do
      email { Faker::Internet.free_email }
      team { Faker::Games::LeagueOfLegends.rank }
      password {"12345678Ka!"}
      password_confirmation {"12345678Ka!"}
    end
  end