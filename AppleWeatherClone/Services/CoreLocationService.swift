//
//  CoreLocationService.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import CoreLocation

protocol CoreLocationServiceDelegate: AnyObject {
    func locationService(_ service: CoreLocationService, didUpdateLocation location: CLLocation)
}

class CoreLocationService: NSObject {
    var locationManager: CLLocationManager
    weak var delegate: CoreLocationServiceDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
}

extension CoreLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.locationService(self, didUpdateLocation: location)
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось получить местоположение: \(error.localizedDescription)")
    }
}
