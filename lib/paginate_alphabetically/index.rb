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
      attribute_value[0].chr.upcase
    end

    def pagination_letters
      @model.all.sort_by{|obj| attribute_value(obj).upcase}.group_by {|group| attribute_value(group)[0].chr.upcase}.keys
    end

    def alphabetical_group(letter = nil)
      letter ||= first_letter
      @model.where(["LOWER(#{attribute.to_s}) LIKE ?", "#{letter.downcase}%"]).order(@attribute)
    end

    private
    def first_instance
      @model.find(:first, :order => attribute, :conditions => ["#{attribute.to_s} >= ?", 'a'])
    end

    def attribute_value(start_object = first_instance)
      attribute_object(start_object).send(attribute)
    end

    def attribute_object(start_object)
      associations.inject(start_object) do |object, method|
        object.send(method)
      end
    end

    def associations
      return []
    end

    def attribute_table_name
      @model.table_name
    end

    def attribute
      @attribute
    end

    class Nested < Index
      def pagination_letters
        @model.includes(*associations).group_by {|group| attribute_value(group)[0].chr.upcase}.keys.sort
      end

      def alphabetical_group(letter = nil)
        letter ||= first_letter
        @model.includes(*associations).
          where(["LOWER(#{attribute_table_name}.#{attribute.to_s}) LIKE ?", "#{letter.downcase}%"]).order("#{attribute_table_name}.#{attribute}")
        end

      private
      def first_instance
        @model.where("#{attribute_table_name}.#{attribute} >= ?", 'a').
          order("#{attribute_table_name}.#{attribute}").joins(*associations).first
      end

      def attribute_table_name
        @model.reflect_on_association(associations.last).table_name
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
