//
//  CityInteractor.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class CityInteractor: CityInteractorProtocol {

    weak var presenter: CityPresenterProtocol?
    let latitude: Double
    let longitude: Double
    let networkManager: NetworkManager<CityWeather>
    let parameters: [String: String]
    let baseURL = "https://api.open-meteo.com/v1/"
    let endPoint = "forecast"
    
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        parameters = [
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
    }
    
    func fetchData() {
        networkManager.fetchData {[weak self] result in
            switch result {
            case .success(let success):
                self?.presenter?.handleSucces(model: success)
            case .failure(let failure):
                self?.presenter?.handleFailure(error: failure.localizedDescription)
            }
        }
    }
    
}
