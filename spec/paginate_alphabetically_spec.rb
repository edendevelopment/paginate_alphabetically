# coding: utf-8
require 'spec_helper'

describe PaginateAlphabetically do
  before do
    %w(one two Three four Five Six).map {|name| Thing.create!(:name => name)}
  end

  after do
    Thing.destroy_all
  end

  context '#pagination_letters' do
    it 'picks out the correct letters from the set' do
      Thing.pagination_letters.should == ['F', 'O', 'S', 'T']
    end

    it 'shows all letters always when asked' do
      Thing.paginate_alphabetically :by => :name, :show_all_letters => true
      Thing.pagination_letters.should == ('A'..'Z').to_a
    end
  end

  context "#first_letter" do
    it "is alphabetical" do
      Thing.create!(:name => ' o noes a space :(')
      Thing.create!(:name => '1')
      Thing.create!(:name => '®')
      Thing.create!(:name => '$')
      Thing.first_letter.should == 'F'
    end

    context "when there are no things" do
      it 'still works' do
        Thing.destroy_all
        Thing.first_letter.should == 'A'
      end
    end
  end

  context "alphabetical group" do
    it "works without specifying letter" do
      Thing.alphabetical_group.map(&:name).should == ['Five', 'four']
    end

    it "works specifying letter" do
      Thing.alphabetical_group('t').map(&:name).should == ['Three', 'two']
    end
  end

  context "class without pagination" do
    it "has no pagination methods" do
      lambda do
        Numpty.alphabetical_group
      end.should raise_error
    end
  end
end
