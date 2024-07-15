//
//  CityViewController.swift
//  AppleWeatherClone
//
//  Created Dmitriy Mikhailov on 15.07.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SnapKit

final class CityViewController: UIViewController, CityViewProtocol {

	var presenter: CityPresenterProtocol?
    
    private lazy var loadIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    private lazy var weatherScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadIndicatorView()
        presenter?.viewDidLoad()
    }
    //MARK: - Setup Load Indicator View
    private func setupLoadIndicatorView() {
        view.backgroundColor = UIColor(named: "BackColor")
        navigationItem.hidesBackButton = true
        view.addSubview(loadIndicatorView)
        loadIndicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    //MARK: - Setup UI
    private func setupUI() {
        loadIndicatorView.stopAnimating()
        loadIndicatorView.isHidden = true
        
        view.addSubview(weatherScrollView)
        
        setupConstraints()
    }
    //MARK: - Setup Constraints
    private func setupConstraints() {
        
        weatherScrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func updateView() {
        setupUI()
    }

}
