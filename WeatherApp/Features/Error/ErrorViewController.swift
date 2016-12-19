//
//  ErrorViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!

    var errorMessage: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let errorMessage = errorMessage else { return }
        errorLabel.text = errorMessage
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
