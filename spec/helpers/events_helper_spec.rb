require 'spec_helper'

describe EventsHelper do
  
  let(:event) { mock_model(Event) }
  
  before do # TODO: code smell. way too complicated. simplify.
    party = mock_model(Category, :name => "Party", :kind => "noun")
    lecture = mock_model(Category, :name => "Lecture", :kind => "noun")
    nouns = [lecture, party]
    
    serious = mock_model(Category, :name => "Serious", :kind => "adjective")
    crunk = mock_model(Category, :name => "Crunk", :kind => "adjective")
    adjectives = [crunk, serious]
    
    event.stub_chain(:categories, :noun => nouns)
    event.stub_chain(:categories, :adjective => adjectives)
  end
  
  describe "#short_description" do
    
    subject { helper.short_description(event) }
    
    it "wraps in a .short-description tag" do
      subject.should have_selector(".short-description")
    end
      
    describe "nouns" do
      
      it "are sorted and separated by a slash" do
        subject.should contain("lecture/party")
      end
      
      it "are wrapped in .category.noun tags" do
        subject.should have_selector(".category.noun", :content => "lecture")
      end
      
    end
    
    describe "adjectives" do
      
      it "are sorted and separated by a comma" do
        subject.should contain("crunk, serious")
      end
      
      it "are wrapped in .category.adjective tags" do
        subject.should have_selector(".category.adjective", :content => "crunk")
      end
      
    end
    
    describe "indefinite article" do
      
      it "is 'a' when it matches the first adjective" do
        subject.should contain(/^A crunk/)
      end
      
      it "is 'an' when it matches the first adjective" do
        awesome = mock_model(Category, :name => "Awesome", :kind => "adjective")
        event.stub_chain(:categories, :adjective => [awesome])

        subject.should contain(/^An awesome/)
      end
      
      context "when an exception to the rule" do
        
        it "is the correct article" do
          pending("Indefinitizer gets support for exceptions")
          
          intervention = mock_model(Category, :name => "Honor", :kind => "noun")
          event.stub_chain(:categories, :noun => [intervention])
          
          subject.should contain(/^An/)  
        end
        
      end
      
    end
    
    context "when no nouns are given" do
    
      before do
        event.stub_chain(:categories, :noun => [])
      end
    
      it "uses 'event' for the noun" do
        subject.should contain("event")
      end
      
    end
    
    context "when no adjectives are given" do
      
      before do
        event.stub_chain(:categories, :adjective => [])
      end
      
      describe "indefinite article" do
        
        it "is 'a' when it matches the first noun" do
          subject.should contain(/^A/)
        end
      
        it "is 'an' when it matches the first noun" do
          intervention = mock_model(Category, :name => "Intervention", :kind => "noun")
          event.stub_chain(:categories, :noun => [intervention])
        
          subject.should contain(/^An/)
        end
        
        context "when an exception to the rule" do
          
          it "is the correct article" do
            pending("Indefinitizer gets support for exceptions")
          
            intervention = mock_model(Category, :name => "Honor", :kind => "noun")
            event.stub_chain(:categories, :noun => [intervention])
            
            subject.should contain(/^An/)  
          end
          
        end
        
      end
      
    end
    
  end
  
  describe "#indefiniteize" do
  
    it "knows exceptions for indefinite articles"
    
  end
  
end