//
//  WeatherType.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import Foundation

enum WeatherType {
    case day(DayWeatherType)
    case night(NightWeatherType)
    
    var isDayTime: Bool {
        return true
    }
    
    var imageName: String {
        switch self {
        case .day(let dayWeather):
            return dayWeather.imageName
        case .night(let nightWeather):
            return nightWeather.imageName
        }
    }
    
    var backgroundImageName: String {
        switch self {
        case .day(let dayWeatherType):
            return dayWeatherType.backgroundImageName
        case .night(let nightWeatherType):
            return nightWeatherType.backgroundImageName
        }
    }
    
    var shortDescription: String {
        switch self {
        case .day(let dayWeather):
            return dayWeather.shortDescription
        case .night(let nightWeather):
            return nightWeather.shortDescription
        }
    }
    
    var description: String {
        switch self {
        case .day(let dayWeather):
            return dayWeather.description
        case .night(let nightWeather):
            return nightWeather.description
        }
    }
}

enum DayWeatherType: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case fortyFive = 45
    case fortyEight = 48
    case fiftyOne = 51
    case fiftyThree = 53
    case fiftyFive = 55
    case fiftySix = 56
    case fiftySeven = 57
    case sixtyOne = 61
    case sixtyThree = 63
    case sixtyFive = 65
    case sixtySix = 66
    case sixtySeven = 67
    case seventyOne = 71
    case seventyThree = 73
    case seventyFive = 75
    case seventySeven = 77
    case eighty = 80
    case eightyOne = 81
    case eightyTwo = 82
    case eightyFive = 85
    case eightySix = 86
    case ninetyFive = 95
    case ninetySix = 96
    case ninetyNine = 99
    case weatherError = 404
    
    var imageName: String {
        switch self {
        case .zero, .one:
            return "01d"
        case .two:
            return "02d"
        case .three:
            return "03d"
        case .fortyFive, .fortyEight:
            return "50d"
        case .fiftyOne, .fiftyThree, .fiftyFive, .fiftySix, .fiftySeven, .eighty, .eightyOne, .eightyTwo:
            return "09d"
        case .sixtyOne, .sixtyThree, .sixtyFive, .sixtySix, .sixtySeven:
            return "10d"
        case .seventyOne, .seventyThree, .seventyFive, .seventySeven, .eightyFive, .eightySix:
            return "13d"
        case .ninetyFive, .ninetySix, .ninetyNine:
            return "11d"
        case .weatherError:
            return ""
        }
    }
    
    var backgroundImageName: String {
        switch self {
        case .zero:
            return "sun"
        case .one:
            return "sun"
        case .two:
            return "cloud"
        case .three:
            return "cloud"
        case .fortyFive:
            return "fog"
        case .fortyEight:
            return "fog"
        case .fiftyOne:
            return "rain"
        case .fiftyThree:
            return "rain"
        case .fiftyFive:
            return "rain"
        case .fiftySix:
            return "rain"
        case .fiftySeven:
            return "rain"
        case .sixtyOne:
            return "rain"
        case .sixtyThree:
            return "rain"
        case .sixtyFive:
            return "rain"
        case .sixtySix:
            return "rain"
        case .sixtySeven:
            return "rain"
        case .seventyOne:
            return "snow"
        case .seventyThree:
            return "snow"
        case .seventyFive:
            return "snow"
        case .seventySeven:
            return "snow"
        case .eighty:
            return "rain"
        case .eightyOne:
            return "rain"
        case .eightyTwo:
            return "rain"
        case .eightyFive:
            return "snow"
        case .eightySix:
            return "snow"
        case .ninetyFive:
            return "rain"
        case .ninetySix:
            return "rain"
        case .ninetyNine:
            return "rain"
        case .weatherError:
            return ""
        }
    }
    
    var shortDescription: String {
        switch self {
        case .zero, .one:
            return "Солнечно"
        case .two, .three:
            return "Облачно"
        case .fortyFive, .fortyEight:
            return "Туманно"
        case .fiftyOne, .fiftyThree, .fiftyFive, .fiftySix, .fiftySeven:
            return "Дождь"
        case .sixtyOne, .sixtyThree, .sixtyFive:
            return "Дождь"
        case .sixtySix, .sixtySeven:
            return "Ледяной дождь"
        case .seventyOne, .seventyThree, .seventyFive, .seventySeven:
            return "Снег"
        case .eighty, .eightyOne, .eightyTwo:
            return "Ливень"
        case .eightyFive, .eightySix:
            return "Снегопады"
        case .ninetyFive:
            return "Гроза"
        case .ninetySix, .ninetyNine:
            return "Гроза с градом"
        case .weatherError:
            return "Не удалось\n получить данные"
        }
    }
    
    var description: String {
        switch self {
        case .zero:
            return "Солнечно"
        case .one:
            return "В основном\nсолнечно"
        case .two:
            return "Частично\nоблачно"
        case .three:
            return "Облачно"
        case .fortyFive:
            return "Туманно"
        case .fortyEight:
            return "Инейный\nтуман"
        case .fiftyOne:
            return "Небольшой\nморосящий\nдождь"
        case .fiftyThree:
            return "Моросящий\nдождь"
        case .fiftyFive:
            return "Сильный\nморосящий\nдождь"
        case .fiftySix:
            return "Небольшой\nледяной\nморосящий\nдождь"
        case .fiftySeven:
            return "Ледяной\nморосящий\nдождь"
        case .sixtyOne:
            return "Небольшой\nдождь"
        case .sixtyThree:
            return "Дождь"
        case .sixtyFive:
            return "Сильный\nдождь"
        case .sixtySix:
            return "Небольшой\nледяной\nдождь"
        case .sixtySeven:
            return "Ледяной\nдождь"
        case .seventyOne:
            return "Небольшой\nснег"
        case .seventyThree:
            return "Снег"
        case .seventyFive:
            return "Сильный\nснег"
        case .seventySeven:
            return "Снежные\nзерна"
        case .eighty:
            return "Небольшие\nливни"
        case .eightyOne:
            return "Ливни"
        case .eightyTwo:
            return "Сильные\nливни"
        case .eightyFive:
            return "Небольшие\nснегопады"
        case .eightySix:
            return "Снегопады"
        case .ninetyFive:
            return "Гроза"
        case .ninetySix:
            return "Небольшие\nгрозы\nс градом"
        case .ninetyNine:
            return "Гроза\nс градом"
        case .weatherError:
            return "Не удалось\n получить данные"
        }
    }
}

enum NightWeatherType: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case fortyFive = 45
    case fortyEight = 48
    case fiftyOne = 51
    case fiftyThree = 53
    case fiftyFive = 55
    case fiftySix = 56
    case fiftySeven = 57
    case sixtyOne = 61
    case sixtyThree = 63
    case sixtyFive = 65
    case sixtySix = 66
    case sixtySeven = 67
    case seventyOne = 71
    case seventyThree = 73
    case seventyFive = 75
    case seventySeven = 77
    case eighty = 80
    case eightyOne = 81
    case eightyTwo = 82
    case eightyFive = 85
    case eightySix = 86
    case ninetyFive = 95
    case ninetySix = 96
    case ninetyNine = 99
    case weatherError = 404
    
    var imageName: String {
        switch self {
        case .zero, .one:
            return "01n"
        case .two:
            return "02n"
        case .three:
            return "03n"
        case .fortyFive, .fortyEight:
            return "50n"
        case .fiftyOne, .fiftyThree, .fiftyFive, .fiftySix, .fiftySeven, .eighty, .eightyOne, .eightyTwo:
            return "09n"
        case .sixtyOne, .sixtyThree, .sixtyFive, .sixtySix, .sixtySeven:
            return "10n"
        case .seventyOne, .seventyThree, .seventyFive, .seventySeven, .eightyFive, .eightySix:
            return "13n"
        case .ninetyFive, .ninetySix, .ninetyNine:
            return "11n"
        case .weatherError:
            return ""
        }
        
    }
    
    var backgroundImageName: String {
        switch self {
        case .zero:
            return "nightsun"
        case .one:
            return "nightsun"
        case .two:
            return "nightcloud"
        case .three:
            return "nightcloud"
        case .fortyFive:
            return "nightfog"
        case .fortyEight:
            return "nightfog"
        case .fiftyOne:
            return "nightrain"
        case .fiftyThree:
            return "nightrain"
        case .fiftyFive:
            return "nightrain"
        case .fiftySix:
            return "nightrain"
        case .fiftySeven:
            return "nightrain"
        case .sixtyOne:
            return "nightrain"
        case .sixtyThree:
            return "nightrain"
        case .sixtyFive:
            return "nightrain"
        case .sixtySix:
            return "nightrain"
        case .sixtySeven:
            return "nightrain"
        case .seventyOne:
            return "nightsnow"
        case .seventyThree:
            return "nightsnow"
        case .seventyFive:
            return "nightsnow"
        case .seventySeven:
            return "nightsnow"
        case .eighty:
            return "nightrain"
        case .eightyOne:
            return "nightrain"
        case .eightyTwo:
            return "nightrain"
        case .eightyFive:
            return "nightsnow"
        case .eightySix:
            return "nightsnow"
        case .ninetyFive:
            return "nightrain"
        case .ninetySix:
            return "nightrain"
        case .ninetyNine:
            return "nightrain"
        case .weatherError:
            return ""
        }
    }
    
    var shortDescription: String {
        switch self {
        case .zero, .one:
            return "Ясно"
        case .two, .three:
            return "Облачно"
        case .fortyFive, .fortyEight:
            return "Туманно"
        case .fiftyOne, .fiftyThree, .fiftyFive, .fiftySix, .fiftySeven:
            return "Дождь"
        case .sixtyOne, .sixtyThree, .sixtyFive:
            return "Дождь"
        case .sixtySix, .sixtySeven:
            return "Ледяной дождь"
        case .seventyOne, .seventyThree, .seventyFive, .seventySeven:
            return "Снег"
        case .eighty, .eightyOne, .eightyTwo:
            return "Ливень"
        case .eightyFive, .eightySix:
            return "Снегопады"
        case .ninetyFive:
            return "Гроза"
        case .ninetySix, .ninetyNine:
            return "Гроза с градом"
        case .weatherError:
            return "Не удалось\n получить данные"
        }
    }
    
    var description: String {
        switch self {
        case .zero:
            return "Ясно"
        case .one:
            return "В основном\nясно"
        case .two:
            return "Частично\nоблачно"
        case .three:
            return "Облачно"
        case .fortyFive:
            return "Туманно"
        case .fortyEight:
            return "Инейный\nтуман"
        case .fiftyOne:
            return "Небольшой\nморосящий\nдождь"
        case .fiftyThree:
            return "Моросящий\nдождь"
        case .fiftyFive:
            return "Сильный\nморосящий\nдождь"
        case .fiftySix:
            return "Небольшой\nледяной\nморосящий\nдождь"
        case .fiftySeven:
            return "Ледяной\nморосящий\nдождь"
        case .sixtyOne:
            return "Небольшой\nдождь"
        case .sixtyThree:
            return "Дождь"
        case .sixtyFive:
            return "Сильный\nдождь"
        case .sixtySix:
            return "Небольшой\nледяной\nдождь"
        case .sixtySeven:
            return "Ледяной\nдождь"
        case .seventyOne:
            return "Небольшой\nснег"
        case .seventyThree:
            return "Снег"
        case .seventyFive:
            return "Сильный\nснег"
        case .seventySeven:
            return "Снежные\nзерна"
        case .eighty:
            return "Небольшие\nливни"
        case .eightyOne:
            return "Ливни"
        case .eightyTwo:
            return "Сильные\nливни"
        case .eightyFive:
            return "Небольшие\nснегопады"
        case .eightySix:
            return "Снегопады"
        case .ninetyFive:
            return "Гроза"
        case .ninetySix:
            return "Небольшие\nгрозы\nс градом"
        case .ninetyNine:
            return "Гроза\nс градом"
        case .weatherError:
            return "Не удалось\n получить данные"
        }
    }
}
