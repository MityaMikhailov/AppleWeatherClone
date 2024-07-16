//
//  SearchViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 16.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class SearchViewController: UIViewController, SearchViewProtocol {

	var presenter: SearchPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - Setup UI
    private func setupUI(){
        view.backgroundColor = .black
    }
    
}
