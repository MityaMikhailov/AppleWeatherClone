//
//  LoadPresenter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class LoadPresenter: LoadPresenterProtocol {

    weak private var view: LoadViewProtocol?
    var interactor: LoadInteractorProtocol?
    private let router: LoadWireframeProtocol

    init(interface: LoadViewProtocol, interactor: LoadInteractorProtocol?, router: LoadWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getCurrentLocation() {
        interactor?.startUpdatingLocation()
    }

    func handleSucces(latitude: Double, longitude: Double, name: String) {
        router.showCityWeather(name: name, latitude: latitude, longitude: longitude)
    }
    
}
