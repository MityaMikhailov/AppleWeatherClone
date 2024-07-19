//
//  SavedCityCell.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 17.07.2024.
//

import UIKit

class SavedCityCell: UITableViewCell {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var cityConditionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(cityLabel)
        stack.addArrangedSubview(conditionLabel)
        stack.spacing = 15
        return stack
    }()
    
    private lazy var maxMinTempStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(maxTempLabel)
        stack.addArrangedSubview(minTempLabel)
        return stack
    }()
    
    private lazy var temperatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(currentTempLabel)
        stack.addArrangedSubview(maxMinTempStack)
        stack.spacing = 15
        return stack
    }()
    
    private lazy var savedCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.selectionStyle = .none
        savedCell.addSubview(backgroundImageView)
        savedCell.addSubview(cityConditionStack)
        savedCell.addSubview(temperatureStack)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cityConditionStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.left.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        temperatureStack.snp.makeConstraints {
            $0.left.equalTo(cityConditionStack.snp.right).offset(15)
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.right.equalToSuperview().inset(15)
        }
        
        savedCell.backgroundColor = .clear
        
        contentView.addSubview(savedCell)
        savedCell.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: CityWeather, name: String) {
        guard let isDay = model.current?.isDay,
              let weatherCode = model.current?.weatherCode,
              let minTemp = model.daily?.temperature2MMin?[0],
              let maxTemp = model.daily?.temperature2MMax?[0] else { return }
        let weatherType = isDay == 1 ? WeatherType.day(DayWeatherType(rawValue: weatherCode)!) : WeatherType.night(NightWeatherType(rawValue: weatherCode)!)
        backgroundImageView.image = UIImage(named: weatherType.backgroundImageName)
        cityLabel.text = name
        currentTempLabel.text = model.current?.temperature2M?.getRoundTemp()
        conditionLabel.text = weatherType.shortDescription
        maxTempLabel.text = "Макс.: " + maxTemp.getRoundTemp()
        minTempLabel.text = ",мин.: " + minTemp.getRoundTemp()
    }
}
