$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

require 'active_support'
require 'active_record'
require 'action_view'

require 'paginate_alphabetically/index'
require 'paginate_alphabetically/active_record'
require 'paginate_alphabetically/view_helpers'

ActiveRecord::Base.extend(PaginateAlphabetically::ActiveRecord)
ActionView::Base.class_eval { include PaginateAlphabetically::ViewHelpers }

include ActionView::Helpers

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

end

load File.expand_path(File.join(File.dirname(__FILE__), 'db/schema.rb'))

class Thing < ActiveRecord::Base
  paginate_alphabetically :by => :name
end

class Numpty < ActiveRecord::Base
end

class Container < ActiveRecord::Base
  belongs_to :thing

  paginate_alphabetically :by => [:thing, :name]

  def full_name
    [thing.name, name].join(" ")
  end
end
