module Cubicle
  module MongoMapper
    module AggregatePlugin
			if ::MongoMapper::Document.respond_to? :append_inclusions
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

if MongoMapper::Document.respond_to? :append_inclusions
	MongoMapper::Document.append_inclusions(Cubicle::MongoMapper::AggregatePlugin)
else
	MongoMapper::Document.plugin(Cubicle::MongoMapper::AggregatePlugin)
end
