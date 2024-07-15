//
//  NameService.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import MapKit

protocol NameServiceDelegate: AnyObject {
    func nameService(_ service: NameService, fetchNames name: String)
}

class NameService {
    
    var location: CLLocation
    weak var delegate: NameServiceDelegate?
    
    init(lallitude: Double, longitude: Double) {
        location = CLLocation(latitude: lallitude, longitude: longitude)
    }
    
    func getName() {
        let geocoder = CLGeocoder()
        
        let locale = Locale(identifier: "ru_RU")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                print("Reverse geocode failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                return
            }
            
            if let city = placemark.locality {
                self.delegate?.nameService(self, fetchNames: city)
            } else {
                print("City name not found")
            }
        }
    }
    
}
