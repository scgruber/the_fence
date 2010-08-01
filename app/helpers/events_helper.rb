module EventsHelper
  
  def short_description(event)
      nouns = event.categories.noun.map(&:name).map(&:downcase).sort # TODO: cleverly de-dupe, please
      adjectives = event.categories.adjective.map(&:name).map(&:downcase).sort
      
      nouns = ["event"] if nouns.empty?
      
      first_word = adjectives.empty? ? nouns.first : adjectives.first
      
      content_tag :span, "#{ indefinite_article_for(first_word).capitalize } #{ adjectives.map{|a| content_tag(:span, a, :class => 'adjective') }.join(", ") } #{ nouns.map{|a| content_tag(:span, a, :class => 'noun') }.join("/") }".squish.html_safe, :class => "short-description"
  end
  
  private
  
  # TODO: replace with something that deals wih exceptions
  def indefinite_article_for(word, consonant = 'a', vowel = 'an')
    result = word.to_s.dup
    result.match(/^([aeiou])/i) ? vowel : consonant
  end
  
end
