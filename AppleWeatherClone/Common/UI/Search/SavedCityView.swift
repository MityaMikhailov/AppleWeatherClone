//
//  SavedCityView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 17.07.2024.
//

import UIKit
import SnapKit
//MARK: - SavedCityViewDelegate
protocol SavedCityViewDelegate: AnyObject {
    func showCityWeather(name: String, latitude: Double, longitude: Double, currentLocation: Bool)
    func removeCity(at index: Int)
    func getListOfCities() -> [UserDefaultType]
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping(CityWeather) -> Void)
}

class SavedCityView: UIView {
    
    private lazy var savedCityTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(SavedCityCell.self, forCellReuseIdentifier: "SavedCityCell")
        return table
    }()
    
    var model: [UserDefaultType]!
    weak var delegate: SavedCityViewDelegate?
    
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
    
    func configure(model: [UserDefaultType]) {
        savedCityTable.dataSource = self
        savedCityTable.delegate = self
        savedCityTable.rowHeight = UITableView.automaticDimension
        savedCityTable.estimatedRowHeight = 300
        self.model = model
    }
    
    func updateTable(model: [UserDefaultType]) {
        self.model = model
        savedCityTable.reloadData()
    }
    
}
//MARK: - UITableViewDataSource
extension SavedCityView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCityCell", for: indexPath) as? SavedCityCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        let latitude = model[indexPath.row].latitude
        let longitude = model[indexPath.row].longitude
        let cityName = model[indexPath.row].name
        
        delegate?.getWeatherData(latitude: latitude, longitude: longitude) { city in
            cell.configure(with: city, name: cityName, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.remove(at: indexPath.row)
            delegate?.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
//MARK: - UITableViewDelegate
extension SavedCityView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = delegate?.getListOfCities()[indexPath.row].name,
              let latitude = delegate?.getListOfCities()[indexPath.row].latitude,
              let longitude = delegate?.getListOfCities()[indexPath.row].longitude
        else { return }
        let currentLocation = indexPath.row == 0 ? true : false
        delegate?.showCityWeather(name: name, latitude: latitude, longitude: longitude, currentLocation: currentLocation)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row != 0 else { return nil }

        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.model.remove(at: indexPath.row)
            self?.delegate?.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }

        deleteAction.image = createDeleteActionImage()
        deleteAction.backgroundColor = .black
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    private func createDeleteActionImage() -> UIImage? {
        let deleteView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        deleteView.backgroundColor = .red
        deleteView.layer.cornerRadius = 30
        deleteView.clipsToBounds = true

        let trashImageView = UIImageView(image: UIImage(systemName: "trash"))
        trashImageView.tintColor = .white
        trashImageView.contentMode = .center
        trashImageView.frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        
        deleteView.addSubview(trashImageView)

        UIGraphicsBeginImageContextWithOptions(deleteView.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        deleteView.layer.render(in: context)
        let actionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return actionImage
    }
}

