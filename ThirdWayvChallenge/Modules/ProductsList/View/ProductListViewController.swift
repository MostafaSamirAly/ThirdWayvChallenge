//
//  ProductListViewController.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import UIKit

class ProductListViewController: UIViewController, AlertShower, LoadingShower {
    
    @IBOutlet weak var productsCollectionView: UICollectionView! {
        didSet {
            setupCollectionView()
        }
    }
    
    let viewModel: ProductsListViewModel
    
    init(viewModel: ProductsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        viewModel.loadProducts(loading: .fullScreen)
        
    }
    

}

fileprivate extension ProductListViewController {
    
    func setupCollectionView() {
        productsCollectionView.registerCellNib(cellClass: ProductCollectionViewCell.self)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
                if let layout = productsCollectionView.collectionViewLayout as? PinterestLayout {
                  layout.delegate = self
                }
        productsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func bindViewModel() {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.productsCollectionView.reloadData()
        }
        viewModel.loading.observe(on: self) { [weak self] in
            switch $0 {
                case .fullScreen:
                    self?.showLoadingView()
                case .noLoading:
                    self?.dismissLoadingView()
                case .nextPage:
                    break
                default:
                    self?.productsCollectionView.restore()
            }
        }
        viewModel.error.observe(on: self) { [weak self] in
            if !$0.isEmpty {
                self?.showAlert(message: $0)
            }
        }
    }
}




extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.items.value.count - 2 {
            viewModel.loadNextPage()
        }
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isEmpty {
            collectionView.setEmptyView(title: "", message: "No Products")
            return 0
        }else {
            collectionView.restore()
            return viewModel.items.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as ProductCollectionViewCell
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
    
}

extension ProductListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.items.value[indexPath.row].image.height)
    }
    
}
