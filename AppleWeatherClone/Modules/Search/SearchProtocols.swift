//
//  SearchProtocols.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol SearchWireframeProtocol: AnyObject {
    func pushToCityWeather(name: String, latitude: Double, longitude: Double, currentLocation: Bool)
    func pushToCityWeatherPage(name: String, latitude: Double, longitude: Double)
}
//MARK: Presenter -
protocol SearchPresenterProtocol: AnyObject {
    func searchCities(searchText: String)
    func searchResults(results: [SearchResult])
    func getResults() -> [SearchResult]
    func showCityWeather(name: String, latitude: Double, longitude: Double, currentLocation: Bool)
    func showCityWeatherPage(name: String, latitude: Double, longitude: Double)
    func getListOfCities() -> [UserDefaultType]
    func fetchData(latitude: Double, longitude: Double, completion: @escaping(CityWeather) -> Void)
    func updateSavedView()
}

//MARK: Interactor -
protocol SearchInteractorProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol?  { get set }
    func getCities(searchText: String)
    func getSaveCities() -> [UserDefaultType]
}

//MARK: View -
protocol SearchViewProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol?  { get set }
    func updateSearchTable()
    func updateSavedView()
}
