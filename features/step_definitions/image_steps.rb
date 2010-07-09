Then /^(?:|I )should see an image with value \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//img', :value => regexp)
    else
      assert page.has_xpath?('//img', :value => regexp)
    end
  end
end