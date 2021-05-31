class ShortUrl < ApplicationRecord
  validates :link, url: true
  validates_length_of :link, :internal_path, maximum: 512
  validates_presence_of :link, :internal_path
  validates_uniqueness_of :internal_path

  after_initialize :set_random_path

  def get_full_short_url(url)
    "#{url}/" + internal_path
  end

  private

  def set_random_path
    self.internal_path = Digest::MD5.hexdigest(Time.now.to_s)
  end
end
