//
//  SearchInteractor.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import MapKit

final class SearchInteractor: SearchInteractorProtocol {

    weak var presenter: SearchPresenterProtocol?
    let nameService = NameService(lallitude: 0, longitude: 0)
    let userDefaultManager = UserDefaultManager<UserDefaultType>(key: "savedCity")
    var networkManager: NetworkManager<CityWeather>!
    
    func getCities(searchText: String) {
        nameService.getCities(searchText: searchText) { [weak self] result in
            self?.presenter?.searchResults(results: result)
        }
    }
    
    func getSaveCities() -> [UserDefaultType] {
        return userDefaultManager.loadItems() ?? []
    }
    
    func removeCity(index: Int) {
        guard var result = userDefaultManager.loadItems() else { return }
        
        result.remove(at: index)
        
        userDefaultManager.saveItem(result)
        
    }
    
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
    
}
