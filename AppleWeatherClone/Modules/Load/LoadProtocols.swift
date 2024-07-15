//
//  LoadProtocols.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol LoadWireframeProtocol: AnyObject {
    func showCityWeather(name: String, latitude: Double, longitude: Double)
}
//MARK: Presenter -
protocol LoadPresenterProtocol: AnyObject {
    func getCurrentLocation()
    func handleSucces(latitude: Double, longitude: Double, name: String)
}

//MARK: Interactor -
protocol LoadInteractorProtocol: AnyObject {
    
    var presenter: LoadPresenterProtocol?  { get set }
    func startUpdatingLocation()
}

//MARK: View -
protocol LoadViewProtocol: AnyObject {
    
    var presenter: LoadPresenterProtocol?  { get set }
}
