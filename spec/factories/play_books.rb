FactoryBot.define do
    factory :play_book do
        name { Faker::Games::LeagueOfLegends.champion }
    end
end
