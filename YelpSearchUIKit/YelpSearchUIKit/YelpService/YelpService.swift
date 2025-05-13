import Foundation

protocol YelpServiceProtocol {
  func queryIceCreamShops() async throws -> Businesses
}

struct YelpService: YelpServiceProtocol {

  private var urlSession: URLSession = URLSession.shared

  func queryIceCreamShops() async throws -> Businesses {
    let searchEndpoint = "https://api.yelp.com/v3/businesses/search"
    let location = "location=47 Winter St. Boston, MA 02108"
    let searchTerm = "term=ice cream"
    let sortBy = "sort_by=best_match"
    let limit = "limit=25"
    guard let url = URL(string: "\(searchEndpoint)?\(location)&\(searchTerm)&\(sortBy)&\(limit)") else {
      throw URLError(.badURL)
    }

    let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
    let businesses = try JSONDecoder().decode(Businesses.self, from: data)
    return businesses
  }
}
