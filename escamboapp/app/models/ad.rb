class Ad < ActiveRecord::Base


  #Constants
  QTT_PER_PAGE = 6

  #RatyRate gem
  ratyrate_rateable "quality"

  #Callbacks
  before_save :md_to_html

  #Associations
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  #Validates
  validates :title, :description_md,:description_short, :category, :price, :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0}


  #Paperclip
  has_attached_file :picture, styles: { 
    large: "800x300#",
  	medium: "320x150#", 
  	thumb: "100x100>" 
  	}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  #gem money-rails
  monetize :price_cents

  #Scopes
  
  scope :descending_order,  -> (page) {
    order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }
  
  scope :search, -> (query,page){
    where("lower(title) LIKE ?", "%#{query.downcase}%").page(page).per(QTT_PER_PAGE)
  }

  scope :last_six, -> {limit(QTT_PER_PAGE).order(created_at: :desc)}
  scope :to_the, -> (current_member) { where(member: current_member) }
  scope :get_all_ads_by_category, -> (category_id,page) {where(category_id: category_id).page(page).per(QTT_PER_PAGE)}


  private
    #Method to convert markdown to html
    def md_to_html
      options = {
          filter_html: true,
          link_attributes: {
            rel: "nofollow",
            target: "_blank"
          }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
    end
end
