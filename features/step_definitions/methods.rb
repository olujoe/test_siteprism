def genCarouselIdFromName(name)
	newname = "tool-#{name.gsub(' ','-').downcase}"
end

def topNavIdFromName(name)
	case name
		when "insurance, loans & banking"
			newname = "button-insurance-loans-banking"
			
		when "family & friends"
			newname = "button-family-friends"	
			
		when "results"
			newname = "button-summary"
	else
		newname = "button-#{name.gsub(' ','-').downcase}"
	end
end

def checkHealthCheckQandA(number,data)
	@browser.h2.text.should == number
	@browser.h3.text.should == data['question']
	numberOfAns = @browser.ul(:class,"answers").lis.length
	numberOfAns.should == data.length - 1
	index = 0
	while(index < numberOfAns)
		exp = data["ans#{index + 1}"]
		actual = @browser.ul(:class,"answers").li(:index,index).text
		actual.include? exp
		index = index + 1
	end
end

def getResetCodeFromMailinatorEmail()
	@browser.goto "http://mailinator.com/inbox.jsp?to=test_mas12345"
	maillists = @browser.ul(:id,"mailcontainer")
	Watir::Wait.until {(@browser.ul(:id,"mailcontainer").text.include? "less than a minute ago")}
	maillists = @browser.ul(:id,"mailcontainer").lis[0].link(:index,0).click
	Watir::Wait.until {(@browser.text.include? "Back to Inbox")}
	sleep(1)
	fulltext = @browser.p(:text,/To reset your password, please click on the link below/).text
	#https://qa.test.moneyadviceservice.org.uk/en/users/password/edit?reset_password_token=KZnEzSpcxoTX9GEzN93r
	links = fulltext.split.last
end