class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :organizers, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings

  def self.pending_requests(event_id)
    Attendance.where(event_id: event_id, state: 'request_sent')
  end

  def slug_candidates
    [
      :title,
      [:title, :location],
    ]
  end

  def self.event_owner(organizer_id)
    User.find_by id: organizer_id
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |t|
      Tag.where(name: t.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).events
  end

  def self.tag_counts
    Tag.select("tags.name, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end
end
