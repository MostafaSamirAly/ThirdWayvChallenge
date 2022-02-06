//
//  UIImageView+Ext.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import UIKit


extension UIImageView {
    func setImage(with url: String) {
        addLoadingIndicator()
            guard let imageUrl = URL(string: url) else { return }
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                if let _ = error {
                    debugPrint("error loading image for url \(url)")
                }else {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage(data: data)
                        self?.removeLoadingIndicator()
                    }
                }
            }.resume()
        }
    
    func addLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.accessibilityIdentifier = "imageLoadingIndicator"
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        self.addSubview(loadingIndicator)
        NSLayoutConstraint.activate( [
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        self.bringSubviewToFront(loadingIndicator)
    }
    
    func removeLoadingIndicator() {
        if let indicator = self.subviews.first (where: { $0.accessibilityIdentifier == "imageLoadingIndicator" }) {
            indicator.removeFromSuperview()
        }
    }
}
