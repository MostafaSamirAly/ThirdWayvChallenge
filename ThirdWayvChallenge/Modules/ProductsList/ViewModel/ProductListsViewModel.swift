//
//  ProductListsViewModel.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import Foundation

struct ProductsListViewModelActions {
    let showProductDetails: (Product) -> Void
    let showProductList: () -> Void
}

enum ProductsListViewModelLoading {
    case fullScreen
    case nextPage
    case noLoading
}

protocol ProductsListViewModelInput {
    func loadProducts(loading: ProductsListViewModelLoading)
    func didLoadNextPage()
}

protocol MoviesListViewModelOutput {
    var items: Observable<[Product]> { get }
    var loading: Observable<ProductsListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
}

protocol ProductsListViewModel: ProductsListViewModelInput, MoviesListViewModelOutput { }


final class DefaultProductsListViewModel: ProductsListViewModel {

    private var productListUseCase: ProductListUseCase
    private let actions: ProductsListViewModelActions?
    
    var items: Observable<[Product]> = Observable([])
    
    var loading: Observable<ProductsListViewModelLoading?> = Observable(.none)
    
    var error: Observable<String> = Observable("")
    
    var isEmpty: Bool { return items.value.isEmpty }
    
    
    init(productListUseCase: ProductListUseCase,
         actions: ProductsListViewModelActions? = nil ) {
        self.productListUseCase = productListUseCase
        self.actions = actions
    }
    
    func loadProducts(loading: ProductsListViewModelLoading) {
        self.loading.value = loading
        productListUseCase.loadData(completion: { [weak self] result in
            self?.loading.value = .noLoading
            switch result {
                case .success(let value):
                    self?.items.value.append(contentsOf: value)
                case .failure(let error):
                    self?.error.value = error.localizedDescription
            }
        })
    }
    
    func didLoadNextPage() {
        loadProducts(loading: .nextPage)
    }
}
