module EventsHelper
  
  def short_description
      nouns = @event.categories.noun.map(&:name).map(&:downcase).sort # TODO: cleverly de-dupe, please
      adjectives = @event.categories.adjective.map(&:name).map(&:downcase).sort
      
      nouns = ["event"] if nouns.empty?
      
      first_word = adjectives.empty? ? nouns.first : adjectives.first
      
      "#{ indefinite_article_for(first_word).capitalize } #{ adjectives.join(", ") } #{ nouns.join("/") }".squish
  end
  
  private
  
  # Primitive, but is it good enough for our purposes?
  def indefinite_article_for(word, consonant = 'a', vowel = 'an')
    result = word.to_s.dup
    result.match(/^([aeiou])/i) ? vowel : consonant
  end
  
end
