//
//  DailyView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 16.07.2024.
//

import UIKit
import SnapKit

class DailyView: UIView {
    
    let dailyTableView = UITableView()
    var heightConstraint: Constraint?
    var model: CityWeather!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup
    private func setup() {
        self.addSubview(dailyTableView)
        dailyTableView.layer.cornerRadius = 15
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(named: "ViewColor")
        dailyTableView.backgroundColor = UIColor(named: "ViewColor")
        dailyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            self.heightConstraint = $0.height.equalTo(dailyTableView.contentSize.height).constraint
        }
        
        observeTableViewContentSize()
    }
    //MARK: - Configure
    func configure(model: CityWeather) {
        self.model = model
        self.dailyTableView.dataSource = self
        self.dailyTableView.allowsSelection = false
        self.dailyTableView.register(DayCell.self, forCellReuseIdentifier: "DayCell")
    }
    //MARK: - Observe TableView ContentSize
    func observeTableViewContentSize() {
        dailyTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            updateHeight()
        }
    }
    //MARK: - Update Height
    func updateHeight() {
        self.heightConstraint?.update(offset: dailyTableView.contentSize.height)
    }

    deinit {
        dailyTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func calculateDailyAverageTemperatures(for temperatures: [Double], days: Int) -> [Double] {
        let hoursPerDay = 24
        var dailyAverages = [Double]()
        
        for day in 0..<days {
            let startIndex = day * hoursPerDay
            let endIndex = startIndex + hoursPerDay
            let dailyTemperatures = temperatures[startIndex..<endIndex]
            let dailyAverage = dailyTemperatures.reduce(0, +) / Double(hoursPerDay)
            dailyAverages.append(dailyAverage)
        }
        
        return dailyAverages
    }
    
}
//MARK: - UI TableView Data Source
extension DailyView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countCell = model.daily?.time?.count else { return 0 }
        return countCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? DayCell,
              let model = model,
              let hourlyTemperatures = model.hourly?.temperature2M,
              let countDays = model.daily?.time?.count
        else { return UITableViewCell() }
        let avverageTemperatures = calculateDailyAverageTemperatures(for: hourlyTemperatures, days: countDays)
        cell.configure(model: model, index: indexPath.row, avverageTemperature: avverageTemperatures[indexPath.row])
        return cell
    }
    
    
}



