# encoding: UTF-8
#############################
# tests/modules/model_tests.rb
#############################
module ModelTests

  # test required attrs
  def test_required_attrs
    raise "@model is not defined" unless @model

    @model.attributes.each do |attr_name, value|
      #skip primary key && nil values
      next if attr_name == @model.class.primary_key || value.nil?

      assert @model.valid?

      @model.send "#{attr_name}=", nil
      refute @model.valid?, "'#{attr_name}' should be required"

      @model.send "#{attr_name}=", value
    end
  end

end
