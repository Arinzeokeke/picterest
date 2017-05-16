FactoryGirl.define do 
	factory :post do
		title {Faker::StarWars.character }
		url {Faker::Internet.url }
		user_id nil

	end
end

							