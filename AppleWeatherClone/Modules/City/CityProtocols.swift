//
//  CityProtocols.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol CityWireframeProtocol: AnyObject {
    
}
//MARK: Presenter -
protocol CityPresenterProtocol: AnyObject {
    func viewDidLoad()
    func handleSucces(model: CityWeather)
    func handleFailure(error: String)
    func getModel() -> CityWeather
    func getName() -> String
}

//MARK: Interactor -
protocol CityInteractorProtocol: AnyObject {
    
    var presenter: CityPresenterProtocol?  { get set }
    func fetchData()
}

//MARK: View -
protocol CityViewProtocol: AnyObject {
    
    var presenter: CityPresenterProtocol?  { get set }
    func updateView()
}
