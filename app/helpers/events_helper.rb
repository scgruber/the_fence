module EventsHelper
  
  def short_description(event)
    categories = event.categories
    
    nouns = categories.noun.map(&:name)
    nouns = ["event"] if nouns.empty?
    
    adjectives = categories.adjective.map(&:name)
    
    first_word = adjectives.empty? ? nouns.first : adjectives.first
    
    adjective_phrase = category_links(adjectives, :class => 'adjective').join(", ")
    noun_phrase = category_links(nouns, :class => 'noun').join("/")
  
    phrase = "#{indefinite_article_for(first_word)} #{adjective_phrase} #{noun_phrase}"
  
    phrase.squish!
    phrase.capitalize!
  
    content_tag :span, phrase.html_safe
  end
  
  private
  
  def category_links(categories, options={})
    categories.map do |category|
      content_tag :span, category, :class => ['category'] + [options[:class]].flatten.compact
    end
  end
  
  # TODO: replace with something that deals wih exceptions
  def indefinite_article_for(word, consonant = 'a', vowel = 'an')
    result = word.to_s.dup
    result.match(/^\W*([aeiou])/i) ? vowel : consonant
  end
  
end
