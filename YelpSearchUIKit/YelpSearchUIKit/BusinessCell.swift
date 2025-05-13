import UIKit

final class BusinessCell: UITableViewCell {

  static let height = 100.0

  private let imageService = ImageService()

  private lazy var customImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .medium, )
    label.textColor = .black.withAlphaComponent(0.9)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  private lazy var streetAddressLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .gray
    return label
  }()

  private lazy var cityLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .gray
    return label
  }()

  private lazy var distanceLabel: UILabel = {
    let label = UILabel()
    label.font = .italicSystemFont(ofSize: 12)
    label.textColor = .gray
    return label
  }()

  private lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = .gray
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.bounds = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    contentView.addSubview(customImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(streetAddressLabel)
    contentView.addSubview(cityLabel)
    contentView.addSubview(distanceLabel)
    self.addSubview(ratingLabel)

    let imageWidth = Self.height
    customImageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth)
    customImageView.backgroundColor = .blue

    print("content width second: \(contentView.bounds.size.width)")
    let textX = customImageView.frame.maxX + 8.0
    let textWidth = contentView.bounds.size.width - imageWidth
    nameLabel.frame = CGRect(x: textX, y: 8.0, width: textWidth, height: nameLabel.font.lineHeight)
    streetAddressLabel.frame = CGRect(x: textX, y: nameLabel.frame.maxY + 8.0, width: textWidth, height: streetAddressLabel.font.lineHeight)
    cityLabel.frame = CGRect(x: textX, y: streetAddressLabel.frame.maxY, width: textWidth, height: cityLabel.font.lineHeight)
    distanceLabel.frame = CGRect(x: textX, y: cityLabel.frame.maxY + 4.0, width: textWidth, height: distanceLabel.font.lineHeight)
    ratingLabel.frame = CGRect(x: self.bounds.size.width + 20.0, // there is no reason I should be able to add 20 here....
                               y: streetAddressLabel.frame.minY,
                               width: imageWidth / 2.0,
                               height: ratingLabel.font.lineHeight)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateBusiness(_ business: Business) {
    nameLabel.text = business.name
    if let meters = business.distanceMeters {
      // TODO this should be localized
      distanceLabel.text = "\(Int(meters))m away"
    }
    streetAddressLabel.text = business.location.displayAddress.first
    cityLabel.text = business.location.displayAddress.count > 1 ? business.location.displayAddress.last : ""
    ratingLabel.text = business.ratingDisplay

    Task {
      do {
        let image = try await imageService.fetchImage(id: business.id, size: Int(Self.height))
        print("cell successfully fetched image: \(image)")
        updateImage(image)
      } catch {
        print("Error fetching business image: \(error)")
      }
    }
  }

  @MainActor
  private func updateImage(_ image: UIImage) {
    customImageView.image = image
    setNeedsLayout()
  }
}
