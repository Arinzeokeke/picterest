FactoryGirl.define do 
	factory :post do |f|
		f.title {Faker::StarWars.character }
		f.url {Faker::Internet.url }
		f.user {FactoryGirl.create(:user)}
	end

	factory :invalid_post, parent: :post do |f|
		f.title nil
		f.user {FactoryGirl.create(:user)}
	end
end

