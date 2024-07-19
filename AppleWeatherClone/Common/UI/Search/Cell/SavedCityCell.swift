//
//  SavedCityCell.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 17.07.2024.
//

import UIKit

class SavedCityCell: UITableViewCell {
    
    private lazy var savedCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var currentLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Текущее место"
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var maxMinTempStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(maxTempLabel)
        stack.addArrangedSubview(minTempLabel)
        return stack
    }()
    
    private lazy var cityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(cityLabel)
        return stack
    }()
    
    private lazy var cityTemperatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(cityStack)
        stack.addArrangedSubview(currentTempLabel)
        return stack
    }()
    
    private lazy var conditionMaxMinStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(conditionLabel)
        stack.addArrangedSubview(maxMinTempStack)
        return stack
    }()
    
    private lazy var cellStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        stack.addArrangedSubview(cityTemperatureStack)
        stack.addArrangedSubview(conditionMaxMinStack)
        return stack
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
        savedCellView.addSubview(backgroundImageView)
        savedCellView.addSubview(cellStack)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        savedCellView.backgroundColor = .clear
        
        contentView.addSubview(savedCellView)
        
        savedCellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with model: CityWeather, name: String, index: Int) {
        guard let isDay = model.current?.isDay,
              let weatherCode = model.current?.weatherCode,
              let minTemp = model.daily?.temperature2MMin?[0],
              let maxTemp = model.daily?.temperature2MMax?[0] else { return }
        let weatherType = isDay == 1 ? WeatherType.day(DayWeatherType(rawValue: weatherCode)!) : WeatherType.night(NightWeatherType(rawValue: weatherCode)!)
        
        if index == 0 {
            cityStack.insertArrangedSubview(currentLocationLabel, at: 0)
            cityLabel.font = .systemFont(ofSize: conditionLabel.font.pointSize, weight: .regular)
        }
        
        backgroundImageView.image = UIImage(named: weatherType.backgroundImageName)
        cityLabel.text = name
        currentTempLabel.text = model.current?.temperature2M?.getRoundTemp()
        conditionLabel.text = weatherType.shortDescription
        maxTempLabel.text = "Макс.: " + maxTemp.getRoundTemp()
        minTempLabel.text = ",мин.: " + minTemp.getRoundTemp()
    }
}
