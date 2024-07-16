//
//  SearchViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController, SearchViewProtocol {

    var presenter: SearchPresenterProtocol?
    
    private lazy var citySearchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.placeholder = "Поиск города или аэропорта"
        searchController.delegate = self
        return searchController
    }()
    
    private lazy var searchTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.backgroundColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        setupTitleView()
        setupCitySearch()
        setupSearchTable()
    }
    
    //MARK: - Setup Title View
    private func setupTitleView() {
        let titleView = UIView()
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.text = "Погода"
        
        titleView.backgroundColor = .clear
        titleView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        navigationItem.titleView = titleView
        
        titleView.snp.makeConstraints {
            $0.width.equalTo(navigationItem.titleView?.snp.width ?? 0)
            $0.height.equalTo(navigationItem.titleView?.snp.height ?? 0)
        }
    }
    //MARK: - Setup citySearchController
    private func setupCitySearch() {
        navigationItem.searchController = citySearchController
    }
    //MARK: - Setup searchTableView
    private func setupSearchTable() {
        view.addSubview(searchTable)
        
        searchTable.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension SearchViewController: UISearchControllerDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
