//
//  HourlyView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 16.07.2024.
//

import UIKit
import SnapKit

class HourlyView: UIView {
    
    let hourlyScrollView = UIScrollView()
    var heightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup
    private func setup() {
        hourlyScrollView.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor(named: "ViewColor")
        self.layer.cornerRadius = 15
        self.addSubview(hourlyScrollView)
        self.snp.makeConstraints {
            self.heightConstraint = $0.height.equalTo(hourlyScrollView.contentSize.height).constraint
        }
        observeScrollViewContentSize()
    }
    //MARK: - Configure Scroll View
    func configureScrollView(with model: CityWeather) {
        
        guard let currentTime = model.current?.time,
              let hourlyTime = model.hourly?.time,
              let hourlyTemperature = model.hourly?.temperature2M,
              let sunrisesTime = model.daily?.sunrise,
              let sunsetsTime = model.daily?.sunset,
              let hourlyWeatherCodes = model.hourly?.weatherCode,
              hourlyTime.count == hourlyTemperature.count
        else { return }
        
        var needFindIndex = true
        var startIndex = 0
        var counter = 0
        
        while needFindIndex {
            if getDateWithHour(date: currentTime) == getDateWithHour(date: hourlyTime[counter]) {
                startIndex = counter
                needFindIndex = false
            }
            counter += 1
        }
        
        hourlyScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        var previosStack = UIStackView()
        
        let endIndex = startIndex + 26
        var counterDay = 0
        
        for i in startIndex...endIndex {
            
            let sunriseTime = Int(getHour(date: sunrisesTime[counterDay]))! + 1
            let sunsetTime = Int(getHour(date: sunsetsTime[counterDay]))!
            let time = Int(getHour(date: hourlyTime[i]))!
            let weatherCode = hourlyWeatherCodes[i]
            
            let weatherType = (sunriseTime...sunsetTime).contains(time) ? WeatherType.day(DayWeatherType(rawValue: weatherCode) ?? .weatherError) : WeatherType.night(NightWeatherType(rawValue: weatherCode) ?? .weatherError )
            
            let hourLabel = UILabel()
            let weatherImageView = UIImageView(image: UIImage(named: weatherType.imageName))
            let temperatureLabel = UILabel()
            
            hourLabel.textColor = .white
            temperatureLabel.textColor = .white
            hourLabel.text = i == startIndex ? "Сейчас" : getHour(date: hourlyTime[i])
            temperatureLabel.text = hourlyTemperature[i].getRoundTemp()
            
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.addArrangedSubview(hourLabel)
            stack.addArrangedSubview(weatherImageView)
            stack.addArrangedSubview(temperatureLabel)
            
            hourlyScrollView.addSubview(stack)
            
            if i == startIndex {
                stack.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(15)
                    $0.top.equalToSuperview().offset(15)
                    $0.bottom.equalToSuperview().inset(15)
                }
            } else if i == endIndex && getDateWithHour(date: hourlyTime[i]) != getDateWithHour(date: sunsetsTime[counterDay]) && getDateWithHour(date: hourlyTime[i]) != getDateWithHour(date: sunrisesTime[counterDay]) {
                stack.snp.makeConstraints {
                    $0.right.equalToSuperview().inset(15)
                    $0.left.equalTo(previosStack.snp.right).offset(15)
                    $0.top.equalToSuperview().offset(15)
                    $0.bottom.equalToSuperview().inset(15)
                }
            } else {
                stack.snp.makeConstraints {
                    $0.left.equalTo(previosStack.snp.right).offset(15)
                    $0.top.equalToSuperview().offset(15)
                    $0.bottom.equalToSuperview().inset(15)
                }
            }
            
            previosStack = stack
            
            if getDateWithHour(date: sunrisesTime[counterDay]) == getDateWithHour(date: hourlyTime[i]) {
                previosStack = setupSunriseStack(sunrisesTime: sunrisesTime, counterDay: counterDay, i: i, endIndex: endIndex, previosStack: previosStack)
            }
            
            if getDateWithHour(date: sunsetsTime[counterDay]) == getDateWithHour(date: hourlyTime[i]) {
                previosStack = setupSunsetStack(sunsetsTime: sunsetsTime, counterDay: counterDay, i: i, endIndex: endIndex, previosStack: previosStack)
            }
            
            if getHour(date: hourlyTime[i]) == "23" {
                counterDay += 1
            }
            
        }
        
    }
    //MARK: - Setup Sunset Stack
    private func setupSunsetStack(sunsetsTime: [String], counterDay: Int, i: Int, endIndex: Int, previosStack: UIStackView) -> UIStackView {
        let sunsetStack = UIStackView()
        sunsetStack.alignment = .center
        sunsetStack.axis = .vertical
        let sunsetLabel = UILabel()
        let sunsetImage = UIImageView(image: UIImage(named: "sunset"))
        let timeSunsetLabel = UILabel()
        
        sunsetLabel.textColor = .white
        timeSunsetLabel.textColor = .white
        
        sunsetLabel.text = "Закат"
        timeSunsetLabel.text = getTime(date: sunsetsTime[counterDay])
        
        sunsetStack.addArrangedSubview(timeSunsetLabel)
        sunsetStack.addArrangedSubview(sunsetImage)
        sunsetStack.addArrangedSubview(sunsetLabel)
        
        hourlyScrollView.addSubview(sunsetStack)
        
        sunsetStack.snp.makeConstraints {
            $0.left.equalTo(previosStack.snp.right).offset(15)
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
        if i == endIndex {
            sunsetStack.snp.makeConstraints {
                $0.right.equalToSuperview().offset(15)
            }
        }
        return sunsetStack
    }
    
    //MARK: - Setup Sunrise Stack
    private func setupSunriseStack(sunrisesTime: [String], counterDay: Int, i: Int, endIndex: Int, previosStack: UIStackView) -> UIStackView {
        let sunriseStack = UIStackView()
        sunriseStack.alignment = .center
        sunriseStack.axis = .vertical
        let sunriseLabel = UILabel()
        let sunriseImage = UIImageView(image: UIImage(named: "sunrise"))
        let timeSunriseLabel = UILabel()
        
        sunriseLabel.textColor = .white
        timeSunriseLabel.textColor = .white
        
        sunriseLabel.text = "Восход солнца"
        timeSunriseLabel.text = getTime(date: sunrisesTime[counterDay])
        
        sunriseStack.addArrangedSubview(timeSunriseLabel)
        sunriseStack.addArrangedSubview(sunriseImage)
        sunriseStack.addArrangedSubview(sunriseLabel)
        
        hourlyScrollView.addSubview(sunriseStack)
        
        sunriseStack.snp.makeConstraints {
            $0.left.equalTo(previosStack.snp.right).offset(15)
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().inset(15)
        }
        if i == endIndex {
            sunriseStack.snp.makeConstraints {
                $0.right.equalToSuperview().offset(15)
            }
        }
        
        return sunriseStack
    }
    
    private func getDateWithHour(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = formatter.date(from: date)
        formatter.dateFormat = "yyyy-MM-dd'T'HH"
        return formatter.string(from: date!)
    }
    
    private func getHour(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = formatter.date(from: date)
        formatter.dateFormat = "HH"
        return formatter.string(from: date!)
    }
    
    private func getTime(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = formatter.date(from: date)
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date!)
    }
    //MARK: - Observe ScrollView ContentSize
    func observeScrollViewContentSize() {
        hourlyScrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            updateHeight()
        }
    }
    
    func updateHeight() {
        self.heightConstraint?.update(offset: hourlyScrollView.contentSize.height)
    }
    
    deinit {
        hourlyScrollView.removeObserver(self, forKeyPath: "contentSize")
    }
}
