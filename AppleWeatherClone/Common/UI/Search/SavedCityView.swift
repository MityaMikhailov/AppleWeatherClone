//
//  SavedCityView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 17.07.2024.
//

import UIKit
import SnapKit

class SavedCityView: UIView {
    
    private lazy var savedCityTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(SavedCityCell.self, forCellReuseIdentifier: "SavedCityCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(savedCityTable)
        savedCityTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(name: String, model: CityWeather) {
        savedCityTable.dataSource = self
    }
    
}

extension SavedCityView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCityCell", for: indexPath)
        return cell
    }
}
