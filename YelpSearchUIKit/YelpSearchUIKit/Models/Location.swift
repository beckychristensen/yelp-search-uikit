import Foundation

struct Location: Codable {
  var streetAddress: String?
  var ciy: String?

  enum CodingKeys: String, CodingKey {
    case streetAddress = "address1"
    case ciy = "city"
  }
}
