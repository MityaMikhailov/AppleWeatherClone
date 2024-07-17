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
    var listOfResult = [SearchResult]()
    var matchingItems: [MKMapItem] = []
    var result = [SearchResult]()
    
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
    
    func getCities(searchText: String, completion: @escaping ([SearchResult]) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self?.result = []
            
            self?.matchingItems = response.mapItems
            
            guard let matchingItems = self?.matchingItems else { return }
            
            for city in matchingItems  {
                guard let cityName = city.name,
                      let country = city.placemark.country else { return }
                let latitude = city.placemark.coordinate.latitude
                let longitude = city.placemark.coordinate.longitude
                
                let r = SearchResult(name: cityName, country: country, latitude: latitude, longitude: longitude)
                self?.result.append(r)
            }
            guard let result = self?.result,
                  result.count > 0 else { return }
            completion(result)
        }
    }
    
}
