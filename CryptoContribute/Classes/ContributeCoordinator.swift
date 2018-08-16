
protocol DonateActionDispatching: AnyObject {
    func dispatch(_ action: DonateViewController.Actions)
}

public final class DonateCoordinator {
    private let qrDisplayViewController = QRDispalyViewController()
    public let donationController = DonateViewController()

    public init() {
        donationController.dispatcher = self
    }
}

extension DonateCoordinator: DonateActionDispatching {
    func dispatch(_ action: DonateViewController.Actions) {
        switch action {
        default: return
        }
    }
}

extension DonateCoordinator {
    private func handleCurrency(_ currency: DonationCurrency) {
        let alert = makeDonateActionSheet(for: currency)
        donationController.present(alert, animated: true, completion: nil)
    }

    private func handleDonation(_ donation: DonateViewController.Actions.Donation) {
        switch donation {
        case let .copyAddress(currency):
            UIPasteboard.general.string = currency.address
            let alert = UIAlertController.confirmationAlert(
                confirmationTitle: "Copied.",
                confirmationMessage: "Wallet address \(currency.address) has been copied to your clipboard."
            )
            donationController.present(alert, animated: true, completion: nil)

        case let .qr(currency):
            qrDisplayViewController.currency = currency
            donationController.present(UINavigationController(rootViewController: qrDisplayViewController), animated: true, completion: nil)
        }
    }

    private func makeDonateActionSheet(for currency: DonationCurrency) -> UIAlertController {
        let alert = UIAlertController(title: "Thanks for wanting to help!",
                                      message: "You can either copy my \(currency.title) wallet address, or scan my wallet's QR Code.",
                                      preferredStyle: .actionSheet)

        let copyAction = UIAlertAction(title: "Copy my \(currency.title) address", style: .default) { [weak self] _ in
            self?.dispatch(.donate(.copyAddress(currency)))
        }

        let qrAction = UIAlertAction(title: "Display my \(currency.title) wallet QR code", style: .default) { [weak self] _ in
            self?.dispatch(.donate(.qr(currency)))
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        [copyAction, qrAction, cancelAction].forEach { action in
            alert.addAction(action)
        }

        return alert
    }
}
