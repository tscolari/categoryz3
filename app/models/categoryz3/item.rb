module Categoryz3
  class Item < ActiveRecord::Base
    belongs_to :category
    belongs_to :categorizable, polymorphic: true
  end
end
