$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

require 'active_support'
require 'active_record'
require 'action_view'

require 'paginate_alphabetically/active_record'
require 'paginate_alphabetically/view_helpers'

ActiveRecord::Base.extend(PaginateAlphabetically::ActiveRecord)
ActionView::Base.class_eval { include PaginateAlphabetically::ViewHelpers }

include ActionView::Helpers

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

load File.expand_path(File.join(File.dirname(__FILE__), 'db/schema.rb'))

class Thing < ActiveRecord::Base
  paginate_alphabetically :by => :name
end

class Numpty < ActiveRecord::Base
end
