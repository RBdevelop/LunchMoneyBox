class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :students
	has_many :charges	

	def total_funds
		if self.charges.any?
			amount = 0
			self.charges.each do |charge|
				if charge.amount
					amount += charge.amount
				end
			end
			amount
		end
	end
end
