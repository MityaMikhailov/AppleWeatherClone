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
    
//    func getCities(searchText: String) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchText
//        
//        let search = MKLocalSearch(request: request)
//        search.start { [weak self] (response, error) in
//            guard let response = response else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            self?.result = []
//            
//            self?.matchingItems = response.mapItems
//            
//            
//            for city in self!.matchingItems  {
//                guard let cityName = city.name,
//                      let country = city.placemark.country else { return }
//                let latitude = city.placemark.coordinate.latitude
//                let longitude = city.placemark.coordinate.longitude
//                
//                let r = SearchResult(name: cityName, country: country, latitude: latitude, longitude: longitude)
//                self?.result.append(r)
//            }
//            guard let result = self?.result else { return }
//            self?.presenter?.searchResults(results: result)
//        }
//        
//    }
    
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
    
}
