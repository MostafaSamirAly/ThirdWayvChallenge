//
//  ProductList.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import UIKit


protocol AlertShower: UIViewController {
    func showAlert(message: String)
}

extension AlertShower {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}



