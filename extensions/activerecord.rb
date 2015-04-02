# encoding: UTF-8
#############################
# extensions/activerecord.rb
#############################
module ActiveRecord
  class Base
    def from_hash hash, options = {}
      representer ? extend(representer).from_hash(hash, options) : super
    end

    def to_json options = {}
      representer ? extend(representer).to_json(options) : super
    end

    private

    def representer
      representer_name = "#{self.class.name.demodulize}Representer"
      Object.const_defined?(representer_name) ? representer_name.constantize : nil
    end
  end
end
