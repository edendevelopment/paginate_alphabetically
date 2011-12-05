# coding: utf-8
require 'spec_helper'

describe PaginateAlphabetically do
  before do
    @one = Thing.create!(:name => 'one')
    @two = Thing.create!(:name => 'two')
    @three = Thing.create!(:name => 'Three')
    @four = Thing.create!(:name => 'four')
    @five = Thing.create!(:name => 'Five')
    @six = Thing.create!(:name => 'Six')

    @nile = Container.create!(:name => 'nile', thing: @four)
    @stour = Container.create!(:name => 'stour', thing: @four)
    @avon = Container.create!(:name => 'avon', thing: @five)
    @amazon = Container.create!(:name => 'amazong', thing: @one)
    @danube = Container.create!(:name => 'danube', thing: @six)
    @rhine = Container.create!(:name => 'rhine', thing: @six)
  end

  after do
    Thing.destroy_all
    Container.destroy_all
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

  context 'associated pagination' do
    it 'is ' do
      Container.first_letter.should == 'F'
    end

    it 'picks out the correct letters from the set' do
      Container.pagination_letters.should == ['F', 'O', 'S']
    end

    it "works without specifying letter" do
      Container.alphabetical_group.map(&:full_name).should == ['Five avon', 'four nile', 'four stour']
    end

    it "works specifying letter" do
      Container.alphabetical_group('s').map(&:full_name).should == ['Six danube', 'Six rhine']
    end
  end
end
