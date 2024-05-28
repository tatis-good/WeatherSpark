//
//  weather.swift
//  Weather
//
//  Created by spark-02 on 2024/05/24.
//

import Foundation
import YumemiWeather

struct Date:Codable{
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


protocol YumemiDelegate {
    func setWeatherError(alert: String)
    func setWeather(weather: Weather)
    }

class WeatherDelegate {
    var delegate: YumemiDelegate?
    
    

    func setWeatherType() {
        let sendJsonString = Date(area: "tokyo",date: "2020-04-01T12:00:00+09:00")
        
        do{
            let encoder = JSONEncoder()
            let jsonDate = try encoder.encode(sendJsonString)
            guard let requestJson = String(data: jsonDate, encoding: .utf8)
            else {return
            }
            
            let fetchWeatherCondition = try YumemiWeather.fetchWeather(requestJson)
            guard let jsonData = fetchWeatherCondition.data(using: .utf8) else{
                return
            }
            let decorer = JSONDecoder()
            let weather  = try decorer.decode(Weather.self, from: jsonData)
            
            guard let jsonData = fetchWeatherCondition.data(using: .utf8)
            else{ return
            }
            delegate?.setWeather(weather: weather)
        }catch{
            delegate?.setWeatherError(alert: "エラー1111")
            
        }
    }
}



















