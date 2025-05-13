import Foundation

struct Location: Codable {
  var streetAddress: String?
  var city: String?
  var displayAddress: [String] = []

  enum CodingKeys: String, CodingKey {
    case streetAddress = "address1"
    case city
    case displayAddress = "display_address"
  }
}
