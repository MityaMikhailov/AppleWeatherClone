//  SearchViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
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
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var searchTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.isHidden = true
        return table
    }()
    
    private var savedCityView: SavedCityView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        setupTitleView()
        setupSavedCityView()
        setupSearchTable()
        setupCitySearch()
    }
    
    //MARK: - Setup Title View
    private func setupTitleView() {
        navigationController?.navigationBar.barTintColor = .clear
        
        let titleView = UIView()
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.text = "Погода"
        
        titleView.backgroundColor = .clear
        titleView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }

        navigationItem.titleView = titleView

        titleView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
            $0.height.equalTo(44)
        }
    }

    //MARK: - Setup citySearchController
    private func setupCitySearch() {
        navigationItem.searchController = citySearchController
        navigationItem.hidesSearchBarWhenScrolling = false
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

    //MARK: - Setup SavedCity View
    func setupSavedCityView() {
        savedCityView = SavedCityView(frame: .zero)
        savedCityView.configure(model: presenter?.getListOfCities() ?? [])
        savedCityView.delegate = self
        view.addSubview(savedCityView)
        savedCityView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    //MARK: - Update searchTableView
    func updateSearchTable() {
        searchTable.reloadData()
    }
}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchTable.isHidden = true
            savedCityView.isHidden = false
            return
        }
        savedCityView.isHidden = true
        searchTable.isHidden = false
        presenter?.searchCities(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTable.isHidden = true
        savedCityView.isHidden = false
    }
}
//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.getResults().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        cell.textLabel?.text = (presenter?.getResults()[indexPath.row].name ?? "") + "," + (presenter?.getResults()[indexPath.row].country ?? "")
        return cell
    }
}
//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter else { return }
        
        presenter.showCityWeatherPage(name: presenter.getResults()[indexPath.row].name,
                                  latitude: presenter.getResults()[indexPath.row].latitude,
                                  longitude: presenter.getResults()[indexPath.row].longitude)
    }
}
//MARK: - SavedCityViewDelegate
extension SearchViewController: SavedCityViewDelegate {
    func showCityWeather(name: String, latitude: Double, longitude: Double, currentLocation: Bool) {
        presenter?.showCityWeather(name: name, latitude: latitude, longitude: longitude, currentLocation: currentLocation)
    }
    
    func removeCity(at index: Int) {
        presenter?.removeCity(at: index)
    }
    
    func getListOfCities() -> [UserDefaultType] {
        guard let listOfCities = presenter?.getListOfCities() else { return [] }
        return listOfCities
    }
    
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (CityWeather) -> Void) {
        presenter?.getWeatherData(latitude: latitude, longitude: longitude, completion: completion)
    }
}
//MARK: - City Delegate
extension SearchViewController: CityDelegate {
    func updateSavedCities() {
        guard let presenter = presenter else { return }
        citySearchController.searchBar.searchTextField.resignFirstResponder()
        citySearchController.searchBar.text = ""
        searchTable.isHidden = true
        savedCityView.isHidden = false
        citySearchController.dismiss(animated: true)
        savedCityView.updateTable(model: presenter.getListOfCities())
    }
}
