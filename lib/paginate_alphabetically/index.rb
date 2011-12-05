module PaginateAlphabetically
  class Index
    def self.for(attribute, model)
      return Nested.new(attribute, model) if attribute.is_a?(Array)
      new(attribute, model)
    end

    def initialize(attribute, model)
      @attribute, @model = attribute, model
    end

    def first_letter
      return 'A' if first_instance.nil?
      first_instance_attribute[0].chr.upcase
    end

    def first_instance
      @model.find(:first, :order => attribute, :conditions => ["#{attribute.to_s} >= ?", 'a'])
    end

    def first_instance_attribute
      attribute_object.send(attribute)
    end

    def attribute_object
      associations.inject(first_instance) do |object, method|
        object.send(method)
      end
    end

    def table_name
      @model.reflect_on_association(associations.last).active_record.table_name
    end

    def associations
      return []
    end

    def attribute
      @attribute
    end

    class Nested < Index

      def first_instance
        @model.where("#{table_name}.#{attribute} >= ?", 'a').
          order("#{table_name}.#{attribute}").joins(Hash[associations]).first
      end

      def associations
        @attribute[0..-2]
      end

      def attribute
        @attribute[-1]
      end
    end
  end
end
