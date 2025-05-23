# yelp-search-uikit
 UIKit version of Yelp search app. I plan to build another version to learn SwiftUI.

 This simple app, on launch, will query Yelp's API to search for ice cream shops near downtown Boston and display a list of the top 25. Photos are fetched asynchronously as cells are scrolled into view and cached using `URLCache`.

 Notes:
 - The Yelp query will not actually work unless `YelpService.apiKey` is replaced with a valid API key
 - Yelp's API no longer includes photo urls on the free trial, so I have instead used [Lorem Picsum](https://picsum.photos/), using the Yelp ID as the seed for a static random image
 - I have not built any error UI, so the screen will be white if you build without setting the API key
 - I would still like to build cancellation into the image fetch in the future (if user scrolls so quickly a cell disappears before the image is fetched)
 - This was my first time using `async/await`, I think I did it correctly



https://github.com/user-attachments/assets/594294b8-dcc6-4415-af91-c94ef6cd2825

![Simulator Screenshot - iPhone 16 Pro (18 3) - 2025-05-22 at 22 07 25](https://github.com/user-attachments/assets/c22b0eb0-1b5a-4a6d-a881-fb9883f79cc3)
