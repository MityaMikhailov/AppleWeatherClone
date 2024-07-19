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
    
    var networkManager: NetworkManager<CityWeather>!

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
    //перенести в интерактор
    func fetchData(latitude: Double, longitude: Double, completion: @escaping(CityWeather) -> Void) {
        let latitude = String(latitude)
        let longitude = String(longitude)
        let baseURL = "https://api.open-meteo.com/v1/"
        let endPoint = "forecast"
        let parameters = [
            "latitude": String(latitude),
            "longitude": String(longitude),
            "current": "temperature_2m,is_day,weather_code",
            "hourly": "temperature_2m,weather_code",
            "daily": "weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset",
            "timezone": "auto",
            "forecast_days": "14"
        ]
        
        self.networkManager = NetworkManager(baseURL:
                                                baseURL,
                                             apiKey: "",
                                             endPoint: endPoint,
                                             parameters: parameters)
        networkManager.fetchData { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateSavedView() {
        view?.updateSavedView()
    }
    
}
