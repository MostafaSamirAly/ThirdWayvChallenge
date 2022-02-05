//
//  ProductListsViewModel.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import Foundation



class ProductListViewModel: NSObject {
    weak var statePresenter: StatePresentable?
    private var productListUseCase: ProductListUseCase
    private(set) var products = [Product]()
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    func loadProducts() {
        statePresenter?.render(state: .loading)
        productListUseCase.loadData(completion: { [weak self] result in
            switch result {
                case .success(let value):
                    self?.products = value
                    self?.statePresenter?.render(state: .populated)
                case .failure(let error):
                    self?.statePresenter?.render(state: .error(error))
            }
        })
    }
}
