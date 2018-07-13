class Site::Profile::AdsController::AdService
	attr_accessor :ad

	def self.create(params_ad, member_id)
		@ad = Ad.new(params_ad)
		@ad.member_id = member_id
		if @ad.valid?
			@ad.save!
		end
		@ad
	end
end