//
//  ProductListViewControllerTest.swift
//  ThirdWayvChallengeTests
//
//  Created by Mostafa Samir on 09/02/2022.
//

import XCTest
@testable import ThirdWayvChallenge

class ProductListViewControllerTest: XCTestCase {
    var productListViewController: ProductListViewController!
    var viewModel: ProductsListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MockProductListViewModel(productListUseCase: MockProductProviderUseCase())
        productListViewController = ProductListViewController(viewModel: viewModel)
        productListViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewModel = nil
        productListViewController = nil
        
    }
    
    func test_outlets_should_be_connected() {
        XCTAssertNotNil(productListViewController.productsCollectionView)
    }
    
    func test_collection_view_delegates_should_be_connected() {
        productListViewController.productsCollectionView.reloadData()
        XCTAssertNotNil(productListViewController.productsCollectionView.dataSource, "dataSource")
        XCTAssertNotNil(productListViewController.productsCollectionView.delegate, "delegate")
    }
    
    func test_view_model_fetching() {
        viewModel.loadProducts(loading: .fullScreen)
        XCTAssertEqual(viewModel.isEmpty, false)
        XCTAssertEqual(viewModel.items.value.count, 10)
        XCTAssertEqual(productListViewController.productsCollectionView.numberOfItems(inSection: 0),
                       viewModel.items.value.count)
        
    }
    
    func test_view_model_failure_request() {
        viewModel.loadProducts(loading: .noLoading)
        XCTAssertEqual(viewModel.error.value.isEmpty, false)
        XCTAssertTrue(productListViewController.viewModel.isEmpty)
    }
    
    func test_user_press_product_item() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.selectAt(indexPath: indexPath)
        XCTAssertNotNil(viewModel.selectedProduct)
    }
    
    
}
