//
//  CityWeather.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import Foundation

// MARK: - CityWeather
struct CityWeather: Codable {
    var name: String?
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let currentUnits: CurrentUnits?
    let current: Current?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?
    let dailyUnits: DailyUnits?
    let daily: Daily?

    enum CodingKeys: String, CodingKey {
        case name
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case hourlyUnits = "hourly_units"
        case hourly
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String?
    let interval: Int?
    let temperature2M: Double?
    let isDay, weatherCode: Int?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case weatherCode = "weather_code"
    }
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time, interval, temperature2M, isDay: String?
    let weatherCode: String?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case isDay = "is_day"
        case weatherCode = "weather_code"
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [String]?
    let weatherCode: [Int]?
    let temperature2MMax, temperature2MMin: [Double]?
    let sunrise, sunset: [String]?

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case sunrise, sunset
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, weatherCode, temperature2MMax, temperature2MMin: String?
    let sunrise, sunset: String?

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case sunrise, sunset
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let weatherCode: [Int]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M, weatherCode: String?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}
