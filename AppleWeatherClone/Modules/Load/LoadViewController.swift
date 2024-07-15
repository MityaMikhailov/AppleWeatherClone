//
//  LoadViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class LoadViewController: UIViewController, LoadViewProtocol {

	var presenter: LoadPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - SetupUI()
    private func setupUI() {
        view.backgroundColor = .white
    }

}
