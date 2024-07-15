//
//  CityRouter.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class CityRouter: CityWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(latitude: Double, longitude: Double) -> UIViewController {
        let view = CityViewController()
        let interactor = CityInteractor(latitude: latitude, longitude: longitude)
        let router = CityRouter()
        let presenter = CityPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
