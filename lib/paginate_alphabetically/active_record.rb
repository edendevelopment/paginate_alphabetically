module PaginateAlphabetically
  ALL_LETTERS = ('0'..'9').to_a + ('A'..'Z').to_a
  module ActiveRecord
    def paginate_alphabetically(params)
      @attribute = params[:by]
      @klass = params[:class]
      @numeric = params[:numeric]
      @paginate_alphabetically__show_all_letters = params[:show_all_letters] || false
      self.extend ClassMethods
    end

    module ClassMethods
      def pagination_letters
        return ALL_LETTERS if @paginate_alphabetically__show_all_letters
        all.sort_by{|obj| obj.send(@attribute).upcase}.group_by {|group| group.send(@attribute)[0].chr.upcase}.keys
      end

      def first_letter
        f_letter = @numeric ? '0' : 'a'
        first_instance = find(:first, :order => "#{@klass.to_s + '.' + @attribute.to_s}", :conditions => ["#{@klass.to_s + '.' + @attribute.to_s} >= ?", f_letter])
        return f_letter if first_instance.nil?
        first_instance.send(@attribute)[0].chr.upcase
      end

      def alphabetical_group(letter = nil)
        letter ||= first_letter
        find(:all, :conditions => ["LOWER(#{@klass.to_s + '.' + @attribute.to_s}) LIKE ?", "#{letter.downcase}%"], :order => "#{@klass.to_s + '.' + @attribute.to_s}")
      end
    end
  end
end
