//
//  File.swift
//  Weather
//
//  Created by spark-02 on 2024/05/29.
//

import Foundation
import YumemiWeather

struct WeatherDate:Codable{
    let area: String
    let date: String
}

struct Weather:Codable{
    var maxTemperature: Int
    var minTemperature: Int
    var fetchWeatherCondition :String
    
    enum CodingKeys: String, CodingKey {
        case maxTemperature = "max_temperature"
        case minTemperature = "min_temperature"
        case fetchWeatherCondition = "weather_condition"
    }

}

struct List:Codable{
    let areas: [String]
    let date: String
    
}
struct AreaResponse:Codable{
    let area: Area
    let info: Weather
}

