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
    
    var name: String
    
    var model: CityWeather! {
        didSet {
            view?.updateView()
        }
    }

    init(interface: CityViewProtocol, interactor: CityInteractorProtocol?, router: CityWireframeProtocol, name: String) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.name = name
    }

    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func handleSucces(model: CityWeather) {
        self.model = model
        interactor?.saveItem(model: model)
    }
    
    func handleFailure(error: String) {
        print(error)
    }
    
    func getModel() -> CityWeather {
        model
    }
    
    func getName() -> String {
        return name
    }
    
    func showSearchScreen() {
        router.pushToSearch()
    }
    
    func isCurrent() -> Bool {
        guard let interactor = interactor else { return false }
        return interactor.getCurrentLocation()
    }
    
    func haveALocation() -> Bool {
        guard let interactor = interactor else { return false }
        return interactor.getHavesLocation()
    }
    
    func addButtonPressed() {
        interactor?.saveSelectItem()
    }
    
}
