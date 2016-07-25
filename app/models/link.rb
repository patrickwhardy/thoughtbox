class Link < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true
  validates :url, :url => true

  def return_status
    if self.read
      return "read"
    else
      return "unread"
    end
  end
end
