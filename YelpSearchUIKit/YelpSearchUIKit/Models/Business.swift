import Foundation

typealias Businesses = [Business]

struct BusinessesResponse: Codable {
  var businesses: Businesses
}

struct Business: Codable {
  var id: String
  var name: String
  var imageURL: String?
  var distanceMeters: Double? // Yelp docs incorrectly label this as string
  var rating: Double? // Yelp docs incorrectly label this as string
  var location: Location

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case imageURL = "image_url"
    case distanceMeters = "distance"
    case rating
    case location
  }

  var ratingDisplay: String {
    return (rating?.description ?? "0.0") + " ★"
  }
}
