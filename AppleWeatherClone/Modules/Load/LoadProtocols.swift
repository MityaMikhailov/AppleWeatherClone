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
    
}
//MARK: Presenter -
protocol LoadPresenterProtocol: AnyObject {
    
}

//MARK: Interactor -
protocol LoadInteractorProtocol: AnyObject {
    
    var presenter: LoadPresenterProtocol?  { get set }
}

//MARK: View -
protocol LoadViewProtocol: AnyObject {
    
    var presenter: LoadPresenterProtocol?  { get set }
}
