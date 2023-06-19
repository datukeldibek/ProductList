//
//  ViewController.swift
//  ProductList
//
//  Created by Jarae on 19/6/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var productsTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private lazy var productsSearchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
        
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var isFiltered: Bool = false
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        setUp()
    }
    
    func setUp() {
        configureTableView()
        configureSearchBar()
        setupConstraints()
    }
    
    func configureTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseId)
    }
    
    func configureSearchBar() {
        productsSearchBar.delegate = self
    }
    
    func setupConstraints() {
        view.addSubview(productsSearchBar)
        productsSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
        }
        view.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(productsSearchBar.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func fetchProducts() {
        Task {
            do {
                let response = try await networkService.requestProducts()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productsTableView.reloadData()
                }
            } catch {
                //
            }
        }
    }
    
    private func filterProducts(with text: String) {
        filteredProducts = products.filter {
            $0.title.lowercased()
                .contains(
                    text.lowercased()
                )
        }
        productsTableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: indexPath) as! ProductTableViewCell
        let model = isFiltered
        ? filteredProducts[indexPath.row]
        : products[indexPath.row]
        cell.display(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UISearchBarDelegates
extension ViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        isFiltered = !searchText.isEmpty
        filterProducts(with: searchText)
    }
}
