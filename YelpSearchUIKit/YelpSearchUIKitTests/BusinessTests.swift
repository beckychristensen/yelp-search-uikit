import XCTest
@testable import YelpSearchUIKit

final class BusinessTests: XCTestCase {

  var business: Business!

  override func setUpWithError() throws {
    business = Business(id: "jfkewjejklf", name: "JP Licks", location: Location())
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testRatingDisplay() {
    business.rating = 4.6
    XCTAssertEqual(business.ratingDisplay, "4.6 ★")
  }
}
