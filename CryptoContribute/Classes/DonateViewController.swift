import Anchorage

enum DonationCurrency {
    case btc
    case eth
    case ltc

    var title: String {
        switch self {
        case .btc: return "Bitcoin"
        case .eth: return "Ethereum"
        case .ltc: return "Litecoin"
        }
    }

    var address: String {
        switch self {
        case .btc: return "3J34NbtHR6YcV4aNDv9qCAEb96tujmZ2nH"
        case .eth: return "0x0cCB57a6617460Cf43fb6C1E00275803beD8aD0A"
        case .ltc: return "MP29JQrv4bXx6RoPZMtYimvEi8AmLZ2xyb"
        }
    }
}

public final class DonateViewController: UIViewController {
    let confettiView = UIView()
    let party = UILabel()
    let header = UILabel()
    let woot = UILabel()
    let donate = DonateView()
    let dismiss = WhiteButton()

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    weak var dispatcher: DonateActionDispatching? {
        didSet {
            donate.dispatcher = dispatcher
        }
    }

    enum Actions {
        enum Donation {
            case qr(DonationCurrency)
            case copyAddress(DonationCurrency)
        }
        case showDonate
        case donate(Donation)
        case presentDonationOptions(DonationCurrency)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overCurrentContext
//        confettiView.startConfetti()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.addSubview(confettiView)
        view.addSubview(party)
        let headerStack = UIStackView(arrangedSubviews: [woot, header])
        headerStack.axis = .vertical
        headerStack.spacing = 12
        view.addSubview(headerStack)

        let stack = UIStackView(arrangedSubviews: [headerStack, donate])
        stack.spacing = 24
        stack.axis = .vertical
        view.addSubview(stack)
        stack.horizontalAnchors == view.horizontalAnchors + 18
        stack.topAnchor == party.bottomAnchor + 18

        confettiView.edgeAnchors == view.edgeAnchors

        header.text = "Thanks for downloading this blockchain viewing application. Bitcoin to the Moon! \n\n If you enjoy using this free app, feel free to send some crypto my way! 💸"
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 20)
        header.textColor = .white
        header.numberOfLines = 0

        party.text = "🚀"
        party.font = UIFont.systemFont(ofSize: 60)
        if #available(iOS 11.0, *) {
            party.topAnchor == view.safeAreaLayoutGuide.topAnchor + 12
        } else {
            // Fallback on earlier versions
        }
        party.centerXAnchor == view.centerXAnchor

        woot.textColor = .white
        woot.centerXAnchor == view.centerXAnchor
        woot.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        woot.textAlignment = .center
        woot.text = "Moon!"

//        confettiView.startConfetti()

        view.addSubview(dismiss)
        dismiss.horizontalAnchors == view.horizontalAnchors + 18

        if #available(iOS 11.0, *) {
            dismiss.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor
        } else {
            // Fallback on earlier versions
        }

        dismiss.heightAnchor == 50
        dismiss.setTitle("Get me outa here!", for: .normal)
        dismiss.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            self.party.transform = .identity
        })
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        party.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }

    @objc private func didTapDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
