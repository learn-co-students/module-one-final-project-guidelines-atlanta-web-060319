class User < ActiveRecord::Base
	has_many :orders
	has_many :sandwiches, :through => :orders
end