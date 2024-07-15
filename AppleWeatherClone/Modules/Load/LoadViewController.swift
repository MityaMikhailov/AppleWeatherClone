//
//  LoadViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SnapKit

final class LoadViewController: UIViewController, LoadViewProtocol {

	var presenter: LoadPresenterProtocol?
    var loadingView: UIView!

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLoadView()
    }
    //MARK: - SetupUI()
    private func setupUI() {
        view.backgroundColor = UIColor(named: "BackColor")
    }
    //MARK: - SetupUI()
    private func setupLoadView() {
        loadingView = LoadingView(frame: .zero)
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
    }

}
