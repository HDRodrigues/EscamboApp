class Site::CategoriesController < SiteController
	def show
		@categories = Category.order_by_description
		@category = Category.friendly.find(params[:id])
		@ads = Ad.get_all_ads_by_category(@category,params[:page])
	end	
end
