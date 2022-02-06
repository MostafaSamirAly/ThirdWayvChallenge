//
//  ProductListsViewModel.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import Foundation

enum ProductsListViewModelLoading {
    case fullScreen
    case nextPage
    case noLoading
}

protocol ProductsListViewModelInput {
    func loadProducts(loading: ProductsListViewModelLoading)
    func loadNextPage()
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
    
    var items: Observable<[Product]> = Observable([])
    
    var loading: Observable<ProductsListViewModelLoading?> = Observable(.none)
    
    var error: Observable<String> = Observable("")
    
    var isEmpty: Bool { return items.value.isEmpty }
    
    var shouldPaginate: Bool = true
    
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    func loadProducts(loading: ProductsListViewModelLoading) {
        self.loading.value = loading
        productListUseCase.loadData(completion: { [weak self] result in
            self?.loading.value = .noLoading
            switch result {
                case .success(let products):
                    self?.items.value.append(contentsOf: products)
                case .failure(let error):
                    self?.error.value = error.localizedDescription
            }
        })
    }
    
    func loadNextPage() {
        loadProducts(loading: .nextPage)
    }
    
}
