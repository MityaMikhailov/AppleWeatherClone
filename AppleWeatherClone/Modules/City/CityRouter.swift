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
    
    static func createModule(latitude: Double, longitude: Double, name: String, currentLocation: Bool) -> UIViewController {
        let view = CityViewController()
        let interactor = CityInteractor(name: name, latitude: latitude, longitude: longitude, currentLocation: currentLocation)
        let router = CityRouter()
        let presenter = CityPresenter(interface: view, interactor: interactor, router: router, name: name)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func pushToSearch() {
        let searchViewController = SearchRouter.createModule()
        viewController?.navigationController?.pushViewController(searchViewController, animated: false)
    }
    
}
