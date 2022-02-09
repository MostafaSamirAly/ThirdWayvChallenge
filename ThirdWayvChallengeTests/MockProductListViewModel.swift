//
//  MockProductListViewModel.swift
//  ThirdWayvChallengeTests
//
//  Created by Mostafa Samir on 09/02/2022.
//

import Foundation
@testable import ThirdWayvChallenge

final class MockProductListViewModel: ProductsListViewModel {
    
    var productListUseCase: ProductListUseCase
    var items: Observable<[Product]> = Observable([])
    var loading: Observable<ProductsListViewModelLoading?> = Observable(nil)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var selectedProduct: Product?
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    func loadProducts(loading: ProductsListViewModelLoading) {
        items.value = []
        switch loading {
            case .fullScreen: // will use this to mock success response
                fetchMockData()
            default: // will use this to mock failure response
                error.value = "Request Failed"
        }
    }
    
    private func fetchMockData() {
        productListUseCase.loadData { [weak self] result in
            switch result {
                case .success(let products):
                    self?.items.value = products
                case .failure(let error):
                    self?.error.value = error.localizedDescription
            }
        }
    }
    func loadNextPage() {
        loadProducts(loading: .nextPage)
    }
    
    func selectAt(indexPath: IndexPath) {
        selectedProduct = items.value[indexPath.row]
    }
    
}
