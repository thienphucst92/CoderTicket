class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    @events = Event.all.order(:starts_at)
  end

  def self.search(search_param)
    where("name ILIKE ?", "%#{search_param}%")
  end

  def venue_name
    venue.present? ? venue.name : nil
  end
end
