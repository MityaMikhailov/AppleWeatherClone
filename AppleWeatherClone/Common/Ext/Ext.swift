//
//  Ext.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import Foundation

extension Double {
    func getRoundTemp() -> String {
        let fractionalPart = self - floor(self)
        return fractionalPart > 0.4 ? String(Int(ceil(self))) + "°" : String(Int(floor(self))) + "°"
    }
}
