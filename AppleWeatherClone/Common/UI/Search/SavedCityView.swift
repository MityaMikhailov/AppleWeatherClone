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
    
    var model: [UserDefaultType]!
    weak var vc: SearchViewController!
    
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
    
    func configure(model: [UserDefaultType], vc: SearchViewController) {
        savedCityTable.dataSource = self
        savedCityTable.delegate = self
        savedCityTable.rowHeight = UITableView.automaticDimension
        savedCityTable.estimatedRowHeight = 300
        self.model = model
        self.vc = vc
    }
    
    func updateTable(model: [UserDefaultType]) {
        print("update")
        self.model = model
        savedCityTable.reloadData()
    }
    
}

extension SavedCityView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCityCell", for: indexPath) as? SavedCityCell else { return UITableViewCell() }
        
        vc.presenter?.fetchData(latitude: model[indexPath.row].latitude, longitude: model[indexPath.row].longitude, completion: { city in
            cell.configure(with: city, name: self.model[indexPath.row].name)
        })
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .green
        cell.contentView.layer.cornerRadius = 15
        return cell
    }
}

extension SavedCityView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Тут сделать делегат
        //Делегат должен вызывать презентер который вызывает роутер и показывает фулл экран погоды
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
