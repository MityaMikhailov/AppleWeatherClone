//
//  SearchRouter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class SearchRouter: SearchWireframeProtocol {
    
    weak var viewController: UIViewController?
    var presenter: SearchPresenterProtocol?
    
    static func createModule() -> UIViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func pushToCityWeather(name: String, latitude: Double, longitude: Double) {
        guard let cityViewController = CityRouter.createModule(latitude: latitude, longitude: longitude, name: name, currentLocation: false) as? CityViewController else { return }
        // Здесь нужно чекнуть имеется ли уже широта и долгота и если да, то показывать полный экран, если нет, то показывать pageSheet и кнопку добавить
        cityViewController.modalPresentationStyle = .pageSheet
        let kek = viewController as? SearchViewController
        cityViewController.updateSavedCitiesClosure = {
            kek?.presenter?.updateSavedView()
        }
        viewController?.navigationController?.present(cityViewController, animated: true)
    }

}
