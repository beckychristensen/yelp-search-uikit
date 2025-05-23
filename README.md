# yelp-search-uikit
 UIKit version of Yelp search app. I plan to build another version to learn SwiftUI.

 This simple app, on launch, will query Yelp's API to search for ice cream shops near downtown Boston and display a list of the top 25. Photos are fetched asynchronously as cells are scrolled into view.

 Notes:
 - The Yelp query will not actually work unless `YelpService.apiKey` is replaced with a valid API key
 - Yelp's API no longer includes photo urls on the free trial, so I have instead used [Lorem Picsum](https://picsum.photos/), using the Yelp ID as the seed for a static random image
 - I have not built any error UI
 - I would like to build cancellation into the image fetch in the future

 
![Simulator Screenshot - iPhone 16 Pro (18 3) - 2025-05-13 at 18 27 07](https://github.com/user-attachments/assets/0668813c-ada6-42df-bbae-068e61d6759e)
