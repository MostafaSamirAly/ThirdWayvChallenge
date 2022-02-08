//
//  ProductDetailsViewController.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 08/02/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    var viewModel: ProductsListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let product = viewModel?.selectedProduct else { return }
        productImageView.setImage(with: product.image.url)
        productDescriptionLabel.text = product.productDescription
        view.layoutIfNeeded()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

}
