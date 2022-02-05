//
//  ProductListViewController.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import UIKit

class ProductListViewController: UIViewController, AlertShower, LoadingShower {
    
    let viewModel = ProductListViewModel(productListUseCase: ProductListProvider())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.statePresenter = self
        viewModel.loadProducts()
    }

}


extension ProductListViewController: StatePresentable {
    func render(state: State) {
        switch state {
            case .loading:
                showLoadingView()
            case .error(let error):
                showAlert(message: error.localizedDescription)
            case .populated:
                dismissLoadingView()
            default:
                break
            
        }
    }
    
    
}
