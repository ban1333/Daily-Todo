class Todo < ApplicationRecord
  include ActiveModel::AttributeMethods
  attribute_method_prefix 'set_'

  attr_accessor :name, :info

  private
  def set_attribute(attribute, modified_value)
    send("#{attribute}=", modified_value)
  end

end
