require 'paginate_alphabetically/active_record'
require 'paginate_alphabetically/view_helpers'

module PaginateAlphabetically
  class Railtie < Rails::Railtie
    initializer "paginate_alphabetically.initialization" do
      ::ActiveRecord::Base.extend(PaginateAlphabetically::ActiveRecord)
      ::ActionView::Base.class_eval { include PaginateAlphabetically::ViewHelpers }
    end
  end
end
