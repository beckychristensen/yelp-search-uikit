import Foundation

protocol YelpServiceProtocol {
  func queryIceCreamShops() async throws -> Businesses
}

struct YelpService: YelpServiceProtocol {

  // TODO do not put API keys in code, use GitHub secrets
  private let apiKey = "API_KEY"

  private var urlSession: URLSession = URLSession.shared

  func queryIceCreamShops() async throws -> Businesses {
    return try await queryBusinesses(searchTerm: "ice cream", location: "47 Winter St. Boston, MA 02108")
  }

  private func queryBusinesses(searchTerm: String, location: String) async throws -> Businesses {
    guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search") else {
      throw URLError(.badURL)
    }

    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "sort_by", value: "best_match"),
      URLQueryItem(name: "limit", value: "25"),
      URLQueryItem(name: "location", value: location),
      URLQueryItem(name: "term", value: searchTerm)
    ]
    let url = baseURL.appending(queryItems: queryItems)
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

    let (data, response) = try await urlSession.data(for: urlRequest)
    let result = try JSONDecoder().decode(BusinessesResponse.self, from: data)
    print("[YelpService] fetched businesses: \(result)")
    return result.businesses
  }
}
