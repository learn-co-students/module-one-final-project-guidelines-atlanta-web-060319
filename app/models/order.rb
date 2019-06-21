class Order < ActiveRecord::Base
	belongs_to :users
	belongs_to :sandwiches

	def self.top3
	 	sandwich_id_array = self.all.map do |order|
	 		order.sandwich_id
	 	end

	 	if sandwich_id_array.length == 0
	 		puts "No one has made any sandwiches yet."
	 		return
	 	end

	 	sandwich_count_array = []
	 	sandwich_id_array.uniq.each do |uniq_sandwich_id|
	 		sandwich_count_array.push([Sandwich.find_by(id: uniq_sandwich_id).name, sandwich_id_array.count(uniq_sandwich_id)])
	 	end

	 	sandwich_count_array = sandwich_count_array.sort do |sandarray1, sandarray2|
	 		sandarray2[1] <=> sandarray1[1]
	 	end

	 	puts "Top 3 Most Popular Chewbecca's Sandwiches!"

	 	sandwich_count_array.take(3).each_with_index do |value, index|
	 		puts "#{index+1}. #{value[0]}"
	 	end
	end
end