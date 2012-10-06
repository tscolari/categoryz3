module Categoryz3
  module Validators
    class ChildItemCategoryValidator < ActiveModel::Validator
      def validate(record)
        unless record.master_item.category.path.map{ |category| category.id }.include?(record.category_id)
          record.errors[:category] << "Must match with master_item.category"
        end
      end
    end
  end
end
