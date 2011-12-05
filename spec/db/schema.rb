ActiveRecord::Schema.define do
  create_table "things", :force => true do |t|
    t.column "name",  :text
  end

  create_table "containers", :force => true do |t|
    t.references "thing"
    t.column "name", :text
  end
end
