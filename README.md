# yelp-search-uikit
 UIKit version of Yelp search app. I plan to build another version to learn SwiftUI.

 This simple app, on launch, will query Yelp's [business search API](https://docs.developer.yelp.com/reference/v3_business_search) to search for ice cream shops near downtown Boston and display a list of the top 25 sorted by best match. Photos are fetched asynchronously as cells are scrolled into view and cached using `URLCache`.

 Notes:
 - The Yelp query will not actually work unless `YelpService.apiKey` is replaced with a valid API key
 - I have not built any error UI, so the screen will be white if you build without setting the API key
 - I would still like to build cancellation into the image fetch in the future (if user scrolls so quickly a cell disappears before the image is fetched)
 - This was my first time using `async/await`, I think I did it correctly
 - In order to show the photos being fetched, I used Network Link Conditioner's LTE setting to record the video below.



https://github.com/user-attachments/assets/1618c9af-2b8c-47c5-bbd9-9df60a6facef

![Simulator Screenshot - iPhone 16 Pro (18 3) - 2025-05-23 at 10 54 35](https://github.com/user-attachments/assets/87fd96e3-15d6-4c6e-9f7a-94490ec5eb8d)
