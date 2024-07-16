//
//  DayCell.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 16.07.2024.
//

import UIKit

class DayCell: UITableViewCell {
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var tempProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = .gray
        progressView.progress = 0.5
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 5
        progressView.progressTintColor = .orange
        return progressView
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup
    private func setup() {
        self.backgroundColor = UIColor(named: "ViewColor")
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(tempProgressView)
        contentView.addSubview(maxTempLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalToSuperview().offset(15)
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalTo(timeLabel.snp.right).offset(15)
            $0.width.equalTo(weatherImageView.snp.height)
        }
        
        minTempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalTo(weatherImageView.snp.right).offset(15)
        }
        
        tempProgressView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(10)
            $0.left.equalTo(minTempLabel.snp.right).offset(15)
        }
        
        maxTempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalTo(tempProgressView.snp.right).offset(15)
            $0.right.equalToSuperview().inset(15)
        }
    }
    //MARK: - Configure
    func configure(model: CityWeather, index: Int) {
        guard let day = model.daily?.time?[index],
              let dailyWeatherCode = model.daily?.weatherCode?[index],
              let minTemp = model.daily?.temperature2MMin?[index],
              let maxTemp = model.daily?.temperature2MMax?[index]
        else { return }
        
        let weatherType = WeatherType.day(DayWeatherType(rawValue: dailyWeatherCode)!)
        
        timeLabel.text = index == 0 ? "Сегодня" : getDay(date: day)
        weatherImageView.image = UIImage(named: weatherType.imageName)
        minTempLabel.text = minTemp.getRoundTemp()
        maxTempLabel.text = maxTemp.getRoundTemp()
    }
    
    private func getDay(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.date(from: date)
        formatter.dateFormat = "EEE"
        return formatter.string(from: date!)
    }
}
