//
//  BaseViewController.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//


import UIKit

class BaseViewController: UIViewController, LoadingShowable {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
    }


}
