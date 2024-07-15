//
//  LoadInteractor.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import CoreLocation

final class LoadInteractor: LoadInteractorProtocol {
    
    weak var presenter: LoadPresenterProtocol?
    var locationService: CoreLocationService!
    var lallitude: Double!
    var longitude: Double!
    
    func startUpdatingLocation() {
        locationService = CoreLocationService()
        locationService.delegate = self
        locationService.startUpdateLocation()
    }
    
}

extension LoadInteractor: CoreLocationServiceDelegate {
    func locationService(_ service: CoreLocationService, didUpdateLocation location: CLLocation) {
        lallitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        let nameService = NameService(lallitude: lallitude, longitude: longitude)
        nameService.delegate = self
        nameService.getName()
    }
}

extension LoadInteractor: NameServiceDelegate {
    func nameService(_ service: NameService, fetchNames name: String) {
        guard let lallitude,
              let longitude else { return }
        presenter?.handleSucces(lallitude: lallitude, longitude: longitude, name: name)
    }
}
