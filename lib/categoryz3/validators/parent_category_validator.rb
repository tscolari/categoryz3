module Categoryz3
  module Validators
    class ParentCategoryValidator < ActiveModel::Validator
      def validate(record)
        if record.parent_id && record.parent.path.map{ |category| category.id }.include?(record.id)
          record.errors[:parent] << "Parent cycle dependency"
        end
        if record.id && record.parent_id == record.id
          record.errors[:parent] << "Can't be parent of itself!"
        end
      end
    end
  end
end
