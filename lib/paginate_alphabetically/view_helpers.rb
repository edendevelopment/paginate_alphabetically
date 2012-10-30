module PaginateAlphabetically
  module ViewHelpers
    def alphabetically_paginate(collection, options = {})
      if options[:always_display]
        available_letters = PaginateAlphabetically::ALL_LETTERS
      else
        return "" if collection.empty?
        available_letters = collection.first.class.pagination_letters
      end
      content_tag(:ul, safe(alphabetical_links_to(available_letters)),
                  :class => options[:class] || "pagination")
    end

    def safe(content)
      if content.respond_to?(:html_safe)
        return content.html_safe
      end
      content
    end

    def alphabetical_links_to(available_letters)
      ('A'..'Z').map do |letter|
        classes = ""
        classes += " current" if current_letter(available_letters) == letter
        classes += " gap" unless available_letters.include?(letter)
        content_tag(:li, paginated_letter(available_letters, letter), :class => classes)
      end.join(" ")
    end

    def current_letter(available_letters)
      params[:letter] || available_letters.first
    end

    def paginated_letter(available_letters, letter)
      if current_letter(available_letters) == letter
        letter
      elsif available_letters.include?(letter)
        link_to(letter, "#{request.path}?letter=#{letter}")
      else
        letter
      end
    end
  end
end
