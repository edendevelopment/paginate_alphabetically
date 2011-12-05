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
        Index.for(@attribute, self).pagination_letters
      end

      def first_letter
        Index.for(@attribute, self).first_letter
      end

      def alphabetical_group(letter = nil)
        Index.for(@attribute, self).alphabetical_group(letter)
      end
    end
  end
end
