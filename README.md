# VippsAssignment

Assignment:
Print the total number of times that the string [topic] appears in the article's text field.

Solutoin:

Logic:
To search topic count from the JSON object of HTML dump following stpes are incorpodated:

WikipediaSearchHomeView is crated for UI with Search textfield and search button.
Validation is added for empty field and Error alert is shown.

On the click of button click for valid topic string, App calls given api and counts total number of times the topic string appears in the artical. 
For this I am converting JSON with html dump to attributedString and filter to string to get topic count.

Code:    
Created SwiftUI project with following MVVM Architecture.
Added Network layer, Data parsing, Extentions, protocol approach and made code loosly coupled to increase testability.



