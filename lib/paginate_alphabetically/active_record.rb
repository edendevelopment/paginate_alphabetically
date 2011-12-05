module PaginateAlphabetically
  ALL_LETTERS = ('A'..'Z').to_a
  module ActiveRecord
    def paginate_alphabetically(params)
      @attribute = params[:by]
      @paginate_alphabetically__show_all_letters = params[:show_all_letters] || false
      self.extend ClassMethods
    end

    module ClassMethods
      def pagination_letters
        return ALL_LETTERS if @paginate_alphabetically__show_all_letters
        all.sort_by{|obj| obj.send(@attribute).upcase}.group_by {|group| group.send(@attribute)[0].chr.upcase}.keys
      end

      def first_letter
        Index.for(@attribute, self).first_letter
      end

      def alphabetical_group(letter = nil)
        letter ||= first_letter
        where(["LOWER(#{@attribute.to_s}) LIKE ?", "#{letter.downcase}%"]).order(@attribute)
      end
    end
  end
end
