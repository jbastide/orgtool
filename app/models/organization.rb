class Organization < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :orgnumber, presence: true, uniqueness: true

  # TODO: We should clarify if every org number should be unique, and
  # whether we have the latitude to create organization numbers or they're
  # provided to us and we just have to deal.

  def self.search_cached(query)
    # I set a short expiration time for testing.
    Rails.cache.fetch("#{query}/org", expires_in: 30.seconds) do
      Organization.find_by name: query
    end
  end


  # Only return an exact match.
  # Vulnerable to sql injection?
  def self.search(query)
    # Get an exact match of the query.

    find_by(name: "#{query}")
  end

end
