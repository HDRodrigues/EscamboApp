class Site::Profile::AdsController < Site::ProfileController
	before_action :set_ad, only: [:edit,:update]
	def index
		# @ads = Ad.where(member_id: current_member.id)
		@ads = Ad.to_the(current_member)
	end

	def edit
	end

	def update
		if @ad.update(params_ad)
			redirect_to site_profile_ads_path, notice: "O Anúncio (#{@ad.title}) foi atualizada com sucesso!"
		else
  			render :edit
  		end
	end

	def new
		@ad = Ad.new
	end

	def create
		@ad  = AdService.create(params_ad, current_member.id)
		unless @ad.errors.any?
			redirect_to site_profile_ads_path, notice: "O Anúncio (#{@ad.title}) foi criado com sucesso!"
		else
			render :new
		end
	end

	private	

	def set_ad
		@ad = Ad.find(params[:id])
	end

	def params_ad
		params.require(:ad).permit(:id,:title,:description,:description_md,:description_short,:price,:category_id, :picture, :finish_date)
	end
end
