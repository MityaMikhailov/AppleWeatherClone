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
    
    private var infoView: InfoView!
    private var hourlyView: HourlyView!
    private var dailyView: DailyView!
    
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
        setupInfoView()
        setupHourlyView()
        setupDailyView()
        setupConstraints()
    }
    //MARK: - Setup Info View
    private func setupInfoView() {
        
        guard let presenter = presenter else { return }
        
        infoView = InfoView(frame: .zero)
        infoView.configure(model: presenter.getModel(), name: presenter.getName())
        weatherScrollView.addSubview(infoView)
    }
    //MARK: - Setup Hourly View
    private func setupHourlyView() {
        
        guard let presenter = presenter else { return }
        
        hourlyView = HourlyView(frame: .zero)
        hourlyView.configureScrollView(with: presenter.getModel())
        weatherScrollView.addSubview(hourlyView)
    }
    //MARK: - Setup Daily View
    private func setupDailyView() {
        guard let presenter = presenter else { return }
        
        dailyView = DailyView(frame: .zero)
        dailyView.configure(model: presenter.getModel())
        weatherScrollView.addSubview(dailyView)
    }
    //MARK: - Setup Constraints
    private func setupConstraints() {
        
        weatherScrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        infoView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        hourlyView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(15)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
        }
        
        dailyView.snp.makeConstraints {
            $0.top.equalTo(hourlyView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(hourlyView.snp.width)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func updateView() {
        setupUI()
    }

}
