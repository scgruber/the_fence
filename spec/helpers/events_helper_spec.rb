require 'spec_helper'

describe EventsHelper do
  
  before do # TODO: code smell. way too complicated. simplify.
    @event = mock_model(Event)
    
    @party = mock_model(Category, :name => "Party", :kind => "noun")
    @lecture = mock_model(Category, :name => "Lecture", :kind => "noun")
    nouns = [@lecture, @party]
    
    @serious = mock_model(Category, :name => "Serious", :kind => "adjective")
    @crunk = mock_model(Category, :name => "Crunk", :kind => "adjective")
    adjectives = [@crunk, @serious]
    
    # FIXME: Stub_chain is being a pain in the ass. de-dupe this.
    @mock_categories = mock("Categories")
    @mock_categories.stub!(:noun => nouns)
    @mock_categories.stub!(:adjective => adjectives)
    @event.stub!(:categories => @mock_categories)
  end
  
  describe "#short_description" do
    
    subject { helper.short_description(@event) }
    
    # it "should be wrapped in a .short-description tag" do
      
    describe "nouns" do
      
      it "should be sorted and separated by a slash" do
        subject.should contain("lecture/party")
      end
      
      it "should be wrapped in .category.noun tags" do
        subject.should have_selector(".category.noun", :content => "lecture")
      end
      
    end
    
    describe "adjectives" do
      
      it "should be sorted and separated by a comma" do
        subject.should contain("crunk, serious")
      end
      
      it "should be wrapped in .category.adjective tags" do
        subject.should have_selector(".category.adjective", :content => "crunk")
      end
      
    end
    
    describe "indefinite article" do
      
      it "should be 'a' when it matches the first adjective" do
        subject.should contain(/^A crunk/)
      end
      
      it "should be 'an' when it matches the first adjective" do
        @awesome = mock_model(Category, :name => "Awesome", :kind => "adjective")
        @mock_categories.stub!(:adjective => [@awesome])

        subject.should contain(/^An awesome/)
      end
      
    end
    
    context "when no nouns are given" do
    
      before do
        @mock_categories.stub!(:noun => [])
      end
    
      it "should use 'event' for the noun" do
        subject.should contain("event")
      end
      
    end
    
    context "when no adjectives are given" do
      
      before do
        @mock_categories.stub!(:adjective => [])
      end
      
      describe "indefinite article" do
        
        it "should be 'a' when it matches the first noun" do
          subject.should contain(/^A lecture/)
        end
      
        it "should be 'an' when it matches the first noun" do
          @lecture = mock_model(Category, :name => "Event", :kind => "noun")
          @mock_categories.stub!(:noun => [])
        
          subject.should contain(/^An event/)
        end
        
      end
      
    end
    
  end
  
  describe "#indefiniteize" do
  
    it "should know exceptions for indefinite articles"
    
  end
  
end