import UIKit

class ViewController: UIViewController {

  private var yelpService: YelpServiceProtocol

  init (yelpService: YelpServiceProtocol = YelpService()) {
    self.yelpService = yelpService
    super.init(nibName: nil, bundle: nil)

    view.backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    Task {
      do {
        let businesses = try await self.yelpService.queryIceCreamShops()
        print("Fetched businesses: \(businesses)")
      } catch {
        print("Error fetching businesses: \(error)")
      }
    }
  }
}
