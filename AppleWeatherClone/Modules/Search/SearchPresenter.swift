//
//  SearchPresenter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class SearchPresenter: SearchPresenterProtocol {
    

    weak private var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    private let router: SearchWireframeProtocol
    var results = [SearchResult]() {
        didSet{
            view?.updateSearchTable()
        }
    }
    
    

    init(interface: SearchViewProtocol, interactor: SearchInteractorProtocol?, router: SearchWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func searchCities(searchText: String) {
        interactor?.getCities(searchText: searchText)
    }
    
    func searchResults(results: [SearchResult]) {
        self.results = results
    }
    
    func getResults() -> [SearchResult] {
        results
    }
    
    func showCityWeather(name: String, latitude: Double, longitude: Double, currentLocation: Bool) {
        router.pushToCityWeather(name: name, latitude: latitude, longitude: longitude, currentLocation: currentLocation)
    }
    
    func showCityWeatherPage(name: String, latitude: Double, longitude: Double) {
        router.pushToCityWeatherPage(name: name, latitude: latitude, longitude: longitude)
    }

    func getListOfCities() -> [UserDefaultType] {
        return interactor?.getSaveCities() ?? []
    }
    
    func removeCity(at: Int) {
        guard let interactor = interactor else { return }
        interactor.removeCity(index: at)
    }
    
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping(CityWeather) -> Void) {
        interactor?.fetchData(latitude: latitude, longitude: longitude, completion: completion)
    }
    
    func updateSavedView() {
        view?.updateSavedView()
    }
    
}
