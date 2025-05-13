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
    // Do any additional setup after loading the view.
  }

}
