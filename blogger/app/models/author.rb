class Author < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body, :password, :message
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_many :articles
end
