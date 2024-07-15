//
//  LoadRouter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class LoadRouter: LoadWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = LoadViewController()
        let interactor = LoadInteractor()
        let router = LoadRouter()
        let presenter = LoadPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func showCityWeather(name: String, latitude: Double, longitude: Double) {
        let cityViewController = CityRouter.createModule(latitude: latitude, longitude: longitude)
        viewController?.navigationController?.pushViewController(cityViewController, animated: false)
    }
}
