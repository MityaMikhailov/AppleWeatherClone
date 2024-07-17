//
//  SearchResult.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 16.07.2024.
//

import Foundation

struct SearchResult: Codable {
    var name: String
    var country: String
    var latitude: Double
    var longitude: Double
}
