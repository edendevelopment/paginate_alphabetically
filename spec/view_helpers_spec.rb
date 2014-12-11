require 'spec_helper'
include PaginateAlphabetically::ViewHelpers


module PaginateAlphabetically
  module ViewHelpers
    def request
      double(:path => '')
    end
  end
end


describe 'View helpers' do
  let(:params) { {letter: 'A'}}

  before do
    Thing.paginate_alphabetically :by => :name, :show_all_letters => false
    @result = alphabetically_paginate([Thing.create!(:name => 'a')])
  end

  it "includes all the letters" do
    ('A'..'Z').each do |letter|
      @result.include?(letter).should be_truthy
    end
  end

  it "links to the available letters" do
    @result.include?('href="?letter=A"').should be_truthy
  end

  it "adds a class to the current letter" do
    @result.include?('selected A').should be_truthy
  end

  it "returns nothing when the collection is empty" do
    alphabetically_paginate([]).should == ''
  end

  it "returns all the letters when the always_display flag is set" do
    alphabetically_paginate([], :always_display => true).should_not == ''
  end

  it "does not link to letters that have no content" do
    @result.include?('href="?letter=B"').should be_falsey
  end

  it "wraps the letters as list items" do
    @result.include?('<li>B</li>').should be_truthy
  end

  it "wraps the result in a ul" do
    @result.include?('<ul class="pagination">').should be_truthy
  end

  it "allows the css class to be overridden" do
    result_with_class = alphabetically_paginate([Thing.create!(:name => 'a')], :class => 'overridden-class')
    result_with_class.include?('class="overridden-class"').should be_truthy
  end
end
