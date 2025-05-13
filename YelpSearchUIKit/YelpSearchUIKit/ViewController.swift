import UIKit

class ViewController: UIViewController {

  static let cellIdentifier = "businessCell"

  private var yelpService: YelpServiceProtocol
  private var businesses: Businesses = []

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(BusinessCell.self, forCellReuseIdentifier: Self.cellIdentifier)
    tableView.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = BusinessCell.height
    tableView.estimatedRowHeight = BusinessCell.height
    tableView.allowsSelection = false
    return tableView
  }()

  init (yelpService: YelpServiceProtocol = YelpService()) {
    self.yelpService = yelpService
    super.init(nibName: nil, bundle: nil)

    view.backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
    let safeArea = view.safeAreaLayoutGuide

    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true

    Task {
      do {
        let fetchedBusinesses = try await self.yelpService.queryIceCreamShops()
        print("Fetched businesses: \(fetchedBusinesses)")
        businesses = fetchedBusinesses
        tableView.reloadData()
      } catch {
        print("Error fetching businesses: \(error)")
      }
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return businesses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? BusinessCell {
      cell.updateBusiness(businesses[indexPath.row])
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    print("setting cell height to: \(BusinessCell.height)")
    return BusinessCell.height
  }
}
