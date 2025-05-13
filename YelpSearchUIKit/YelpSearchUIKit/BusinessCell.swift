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
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textColor = .black.withAlphaComponent(0.9)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  private lazy var distanceLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .medium)
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.bounds = self.bounds

    contentView.addSubview(customImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(distanceLabel)

    let imageWidth = Self.height
    customImageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth)
    customImageView.backgroundColor = .blue

    print("content width second: \(contentView.bounds.size.width)")
    nameLabel.frame = CGRect(x: customImageView.frame.maxX + 8.0, y: 8.0, width: contentView.bounds.size.width - imageWidth, height: nameLabel.font.lineHeight)
    print("name label width: \(nameLabel.frame.size.width)")

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateBusiness(_ business: Business) {
    nameLabel.text = business.name
    if let meters = business.distanceMeters {
      distanceLabel.text = "\(Int(meters))m"
    }

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
    print("imageview size is now: \(customImageView.bounds.size)")
  }
}
