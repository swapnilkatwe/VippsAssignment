# WikiTopicSearchAssignment

Assignment:
Print the total number of times that the string [topic] appears in the article's text field.

Solution:

Logic:
To search topic count from the JSON object of HTML dump following steps are incorpodated:

WikipediaSearchHomeView is created for UI with a Search text field and search button.
Validation is added for empty field and Error alert is shown.

On the click of the button click for a valid topic string, the App calls the given api and counts a total number of times the topic string appears in the article. 
For this, I am converting JSON with html dump to attributedString and filter to string to get topic count.

Code:    
Created SwiftUI project with the following MVVM Architecture.
Added Network layer, Data parsing, extensions, and protocol approach and made code loosely coupled to increase testability.



