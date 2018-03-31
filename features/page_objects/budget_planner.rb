require 'capybara'
require 'site_prism'

module PageObjects
	class MenuSection < SitePrism::Section
  		element :search, "a.search"
  		element :images, "a.image-search"
  		element :maps, "a.map-search"
	end

	# define sections used on multiple pages or multiple times on one page

	class SearchResultSection < SitePrism::Section
  		element :title, "a.title"
  		element :blurb, "span.result-decription"
	end

	class Home < SitePrism::Page
  		set_url "/index.htm"
  		set_url_matcher /google.com\/?/

  		element :search_field, "input[name='q']"
  		element :search_button, "button[name='btnK']"
  		elements :footer_links, "#footer a"
  		section :menu, MenuSection, "#gbx3"
	end

	class SearchResults < SitePrism::Page
  		set_url_matcher /google.com\/results\?.*/

  		section :menu, MenuSection, "#gbx3"
		sections :search_results, SearchResultSection, "#results li"

		def search_result_links
			search_results.map {|sr| sr.title['href']}
		end
	end
end

# now for some tests

When /^I navigate to the google home page$/ do
  @home = Home.new
  @home.load
end

Then /^the home page should contain the menu and the search form$/ do
  @home.wait_for_menu # menu loads after a second or 2, give it time to arrive
  @home.should have_menu
  @home.should have_search_field
  @home.should have_search_button
end

When /^I search for Sausages$/ do
  @home.search_field.set "Sausages"
  @home.search_button.click
end

Then /^the search results page is displayed$/ do
  @results_page = SearchResults.new
  @results_page.should be_displayed
end

Then /^the search results page contains 10 individual search results$/ do
  @results_page.wait_for_search_results
  @results_page.should have_search_results
  @results_page.search_results.size.should == 10
end

Then /^the search results contain a link to the wikipedia sausages page$/ do
  @results_page.search_result_links.should include "http://en.wikipedia.org/wiki/Sausage"
end
