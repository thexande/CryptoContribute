import UIKit
import Anchorage
import QRCode

final class QRDispalyViewController: UIViewController {
    let image = UIImageView()

    public var address: String = "" {
        didSet {
            let qrCode = QRCode(address)
            image.image = qrCode?.image
        }
    }

    var currency: DonationCurrency? {
        didSet {
            if let currency = currency {
                address = currency.address
                title = "Donate \(currency.title)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(image)

        image.heightAnchor == (view.heightAnchor - 64) / 2
        image.heightAnchor == image.widthAnchor
        image.centerAnchors == view.centerAnchors
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(done))
    }

    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
}
