module Cubicle
  module Mongoid
    module AggregatePlugin
      if ::Mongoid::Document.respond_to? :append_inclusions
        def self.included(model)
          model.plugin AggregatePlugin
        end
      else
        extend ActiveSupport::Concern
      end

      module ClassMethods
        def aggregate(&block)
          return Cubicle::Aggregation::AdHoc.new(self.collection_name,&block)
        end
      end
    end
  end
end

if Mongoid::Document.respond_to? :append_inclusions
  Mongoid::Document.append_inclusions(Cubicle::Mongoid::AggregatePlugin)
else
  Mongoid::Document.plugin(Cubicle::Mongoid::AggregatePlugin)
end
