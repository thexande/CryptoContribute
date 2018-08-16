//
//  ViewController.swift
//  CryptoContribute
//
//  Created by Alexander Murphy on 08/15/2018.
//  Copyright (c) 2018 Alexander Murphy. All rights reserved.
//

import UIKit
import CryptoContribute

class ViewController: UIViewController {
    let coordinator = DonateCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(coordinator.donationController, animated: true, completion: nil)
    }
}

