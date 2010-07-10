require 'spec_helper'

describe EventsHelper do
  
  before do # TODO: code smell. way too complicated. simplify.
    @event = mock_model(Event)
    
    @party = mock_model(Category, :name => "Party", :kind => "noun")
    @lecture = mock_model(Category, :name => "Lecture", :kind => "noun")
    nouns = [@party, @lecture]
    
    @serious = mock_model(Category, :name => "Serious", :kind => "adjective")
    @crunk = mock_model(Category, :name => "Crunk", :kind => "adjective")
    adjectives = [@serious, @crunk]
    
    # FIXME: Stub_chain is being a pain in the ass. de-dupe this.
    @mock_categories = mock("Categories")
    @mock_categories.stub!(:noun => nouns)
    @mock_categories.stub!(:adjective => adjectives)
    @event.stub!(:categories => @mock_categories)
  end
  
  describe "#short_description" do
    
    it "should include the nouns separated by a slash" do
      helper.short_description.should include("lecture/party")
    end
    
    it "should include the adjectives separated by a comma" do
      helper.short_description.should include("crunk, serious")
    end
    
    it "should begin with indefinite article 'a' when called for by adjective" do
      helper.short_description.should match(/^A crunk/)
    end
    
    it "should begin with indefinite article 'an' when called for by adjective" do
      @awesome = mock_model(Category, :name => "Awesome", :kind => "adjective")
      @mock_categories.stub!(:adjective => [@awesome])
      
      helper.short_description.should match(/^An awesome/)
    end
    
    context "when do nouns are given" do
    
      before do
        @mock_categories.stub!(:noun => [])
      end
    
      it "should use 'event' for the noun" do
        helper.short_description.should include("event")
      end
      
    end
    
    context "when no adjectives are given" do
      
      before do
        @mock_categories.stub!(:adjective => [])
      end
      
      it "should begin with indefinite article 'a' when called for by noun" do
        helper.short_description.should match(/^A lecture/)
      end
      
      it "should begin with indefinite article 'an' when called for by noun" do
        @lecture = mock_model(Category, :name => "Event", :kind => "noun")
        @mock_categories.stub!(:noun => [])
        
        helper.short_description.should match(/^An event/)
      end
      
    end
    
  end
  
  describe "#indefiniteize" do
  
    it "should know exceptions for indefinite articles"
    
  end
  
end