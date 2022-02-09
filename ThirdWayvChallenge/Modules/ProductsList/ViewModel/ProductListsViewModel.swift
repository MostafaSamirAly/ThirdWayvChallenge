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
    var productListUseCase: ProductListUseCase { get } 
    init(productListUseCase: ProductListUseCase)
    func loadProducts(loading: ProductsListViewModelLoading)
    func loadNextPage()
    func selectAt(indexPath: IndexPath)
}

protocol MoviesListViewModelOutput {
    var items: Observable<[Product]> { get }
    var loading: Observable<ProductsListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var selectedProduct: Product? { get }
}

protocol ProductsListViewModel: ProductsListViewModelInput, MoviesListViewModelOutput { }


final class DefaultProductsListViewModel: ProductsListViewModel {

    var productListUseCase: ProductListUseCase
    
    var items: Observable<[Product]> = Observable([])
    var loading: Observable<ProductsListViewModelLoading?> = Observable(.none)
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var shouldPaginate: Bool = false
    var selectedProduct: Product?
    
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    func loadProducts(loading: ProductsListViewModelLoading) {
        self.loading.value = loading
        productListUseCase.loadData(completion: { [weak self] result, isFromCache in
            self?.loading.value = .noLoading
            switch result {
                case .success(let products):
                    if isFromCache,
                       self?.shouldPaginate == false {
                        self?.items.value = products
                    }else {
                        self?.items.value.append(contentsOf: products)
                    }
                    self?.shouldPaginate = !isFromCache
                case .failure(let error):
                    self?.error.value = error.localizedDescription
            }
        })
    }
    
    func loadNextPage() {
        if shouldPaginate {
            loadProducts(loading: .nextPage)
        }
    }
    
    func selectAt(indexPath: IndexPath) {
        selectedProduct = items.value[indexPath.row]
    }
}
