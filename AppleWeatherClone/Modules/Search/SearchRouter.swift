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
        let cityViewController = CityRouter.createModule(latitude: latitude, longitude: longitude, name: name)
        //Здесь нужно чекнуть имеетлся ли уже широта и долгота и если да то показывать полный экран, если нет то показывать pageSheet и кнопку добавить
        cityViewController.modalPresentationStyle = .pageSheet
        viewController?.navigationController?.present(cityViewController, animated: true)
    }
}
