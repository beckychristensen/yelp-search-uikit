import UIKit

protocol ImageServiceProtocol {

}

struct ImageService: ImageServiceProtocol {

  private var urlSession: URLSession = URLSession.shared
  private var urlCache: URLCache = URLCache.shared

  func fetchImage(id: String, size: Int) async throws -> UIImage {
    guard let url = URL(string: "https://picsum.photos/seed/\(id)/\(size)/\(size)") else {
      print("[ImageService] bad url")
      throw URLError(.badURL)
    }

    let urlRequest = URLRequest(url: url)
    if let cachedData = urlCache.cachedResponse(for: URLRequest(url: url))?.data, let cachedImage = UIImage(data: cachedData) {
      print("[ImageService] using cached image for \(url.absoluteString)")
      return cachedImage
    } else {
      let (data, response) = try await URLSession.shared.data(for: urlRequest)
      guard let httpResponse = response as? HTTPURLResponse else {
        print("[ImageService] bad server response")
        throw URLError(.badServerResponse)
      }
      guard httpResponse.statusCode == 200 else {
        print("[ImageService] bad status code: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
      }
      guard let fetchedImage = UIImage(data: data) else {
        print("[ImageService] could not decode image data")
        throw URLError(.badServerResponse)
      }
      print("[ImageService] fetched new image for \(url.absoluteString)")
      urlCache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
      return fetchedImage
    }
  }
}
