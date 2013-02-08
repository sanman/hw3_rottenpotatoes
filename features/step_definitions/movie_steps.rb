# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  title1 = page.body.index(e1)
  title2 = page.body.index(e2)
  title1.should < title2
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck.eql? 'un'
  rating_list.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}}
  else
  rating_list.split(', ').each {|x| step %{I check "ratings_#{x}"}}
  end
end

Then /^I should see all of the movies "([^"]*)"$/ do |number_of_movies|
  page.should have_css("table#movies tbody tr", :count => number_of_movies.to_i)
end

Then /^I should see none of the movies "([^"]*)"$/ do |number_of_movies|
  page.should have_css("table#movies tr", :count => number_of_movies.to_i)
end

