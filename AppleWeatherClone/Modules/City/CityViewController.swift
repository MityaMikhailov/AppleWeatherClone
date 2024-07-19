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

protocol CityDelegate: AnyObject {
    func updateSavedCities()
}

final class CityViewController: UIViewController, CityViewProtocol {

	var presenter: CityPresenterProtocol?
    weak var delegate: CityDelegate?
    
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
    
    let footerView = UIView()
    let citySearchButton = UIButton(type: .system)
    let headerView = UIView()
    
    private var infoView: InfoView!
    private var hourlyView: HourlyView!
    private var dailyView: DailyView!
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadIndicatorView()
        presenter?.viewDidLoad()
    }

    //MARK: - Setup Load Indicator View
    private func setupLoadIndicatorView() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackColor")
        view.backgroundColor = UIColor(named: "BackColor")
        
        view.addSubview(weatherScrollView)
        
        infoView = InfoView(frame: .zero)
        hourlyView = HourlyView(frame: .zero)
        dailyView = DailyView(frame: .zero)
        
        weatherScrollView.addSubview(infoView)
        weatherScrollView.addSubview(hourlyView)
        weatherScrollView.addSubview(dailyView)
        
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
        setupHeaderView()
        setupFooterView()
        setupInfoView()
        setupHourlyView()
        setupDailyView()
        setupConstraints()
    }

    //MARK: - Setup Header View
    private func setupHeaderView() {
        guard let presenter = presenter else { return }
        view.addSubview(headerView)
        headerView.backgroundColor = .clear
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
        }
        if !presenter.haveALocation() && !presenter.isCurrent() {
            headerView.addSubview(addButton)
            headerView.addSubview(cancelButton)
            
            addButton.snp.makeConstraints {
                $0.right.equalToSuperview().inset(15)
                $0.centerY.equalToSuperview()
            }
            
            cancelButton.snp.makeConstraints {
                $0.left.equalToSuperview().inset(15)
                $0.centerY.equalToSuperview()
            }
            
            headerView.snp.makeConstraints {
                $0.height.equalTo(44)
            }
        }
    }

    //MARK: - Setup Footer View
    private func setupFooterView() {
        footerView.backgroundColor = UIColor(named: "BackColor")
        view.addSubview(footerView)
        
        footerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        
        citySearchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        citySearchButton.setImage(UIImage(named: "menu"), for: .normal)
        citySearchButton.tintColor = .white
        footerView.addSubview(citySearchButton)
        
        citySearchButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
    }

    //MARK: - Setup Info View
    private func setupInfoView() {
        guard let presenter = presenter else { return }
        infoView.configure(model: presenter.getModel(), name: presenter.getName(), currentLocation: presenter.isCurrent())
    }

    //MARK: - Setup Hourly View
    private func setupHourlyView() {
        guard let presenter = presenter else { return }
        hourlyView.configureScrollView(with: presenter.getModel())
    }

    //MARK: - Setup Daily View
    private func setupDailyView() {
        guard let presenter = presenter else { return }
        dailyView.configure(model: presenter.getModel())
    }

    //MARK: - Setup Constraints
    private func setupConstraints() {
        weatherScrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(footerView.snp.top)
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
        }
    }

    @objc private func searchButtonTapped() {
        presenter?.showSearchScreen()
    }
    
    @objc private func addButtonTapped() {
        presenter?.addButtonPressed()
        dismiss(animated: true) { [weak self] in
            self?.delegate?.updateSavedCities()
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    func updateView() {
        setupUI()
    }
}

extension CityViewController {
    override func viewDidLayoutSubviews() {
        let totalHeight = infoView.bounds.height + hourlyView.bounds.height + dailyView.bounds.height + 15 + 100
        weatherScrollView.contentSize.height = totalHeight
    }
}
