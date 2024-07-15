//
//  CityPresenter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class CityPresenter: CityPresenterProtocol {

    weak private var view: CityViewProtocol?
    var interactor: CityInteractorProtocol?
    private let router: CityWireframeProtocol
    
    var model: CityWeather! {
        didSet {
            view?.updateView()
        }
    }

    init(interface: CityViewProtocol, interactor: CityInteractorProtocol?, router: CityWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func handleSucces(model: CityWeather) {
        self.model = model
    }
    
    func handleFailure(error: String) {
        print(error)
    }
    
    func getModel() -> CityWeather {
        model
    }
    
}
