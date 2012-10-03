module Categoryz3
  class ChildItem < ActiveRecord::Base
    belongs_to :category
    belongs_to :categorizable, polymorphic: true
  end
end
