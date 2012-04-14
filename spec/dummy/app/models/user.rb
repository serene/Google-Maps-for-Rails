class User < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude, :name, :picture
end
