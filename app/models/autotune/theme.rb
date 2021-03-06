module Autotune
  # Themes for blueprints
  class Theme < ActiveRecord::Base
    has_and_belongs_to_many :blueprints
    validates :value, :label, :presence => true
    validates :value,
              :uniqueness => true,
              :format => { :with => /\A[0-9a-z\-_]+\z/ }
  end
end
