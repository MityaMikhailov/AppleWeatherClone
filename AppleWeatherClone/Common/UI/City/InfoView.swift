//
//  InfoView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import UIKit
import SnapKit

class InfoView: UIView {

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()

    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 70)
        return label
    }()

    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(cityLabel)
        return stack
    }()

    private lazy var temperatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(maxTempLabel)
        stack.addArrangedSubview(minTempLabel)
        return stack
    }()

    private lazy var conditionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addArrangedSubview(conditionLabel)
        stack.addArrangedSubview(temperatureStack)
        return stack
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addArrangedSubview(locationStack)
        stack.addArrangedSubview(currentTempLabel)
        stack.addArrangedSubview(conditionsStack)
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(infoStack)
        self.backgroundColor = .clear
        infoStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(infoStack.snp.height)
        }
    }

    func configure(model: CityWeather, name: String) {
        guard let temperature = model.current?.temperature2M,
              let maxTemp = model.daily?.temperature2MMax?[0],
              let minTemp = model.daily?.temperature2MMin?[0],
              let weatherCode = model.current?.weatherCode,
              let isDay = model.current?.isDay else { return }

        let weatherType = isDay == 1 ? WeatherType.day(DayWeatherType(rawValue: weatherCode)!) : WeatherType.night(NightWeatherType(rawValue: weatherCode)!)

        cityLabel.text = name
        currentTempLabel.text = " " + temperature.getRoundTemp()
        conditionLabel.text = weatherType.description
        maxTempLabel.text = "Макс.: " + maxTemp.getRoundTemp()
        minTempLabel.text = ",мин.: " + minTemp.getRoundTemp()
    }
}

