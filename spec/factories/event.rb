FactoryBot.define do
    factory :event do
        opponent { Faker::Games::Pokemon.name }
        event_date {Faker::Date.between(50.years.ago, 15.years.ago) } 
    end
end
