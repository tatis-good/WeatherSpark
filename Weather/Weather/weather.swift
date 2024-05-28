//
//  weather.swift
//  Weather
//
//  Created by spark-02 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol YumemiDelegate {
    func setWeatherType(type: String)
    func setWeatherError(alert: String)
    func setmaxTemperature(max: Int)
    func setminTemperature(min: Int)
    }

class WeatherDelegate {
    var delegate: YumemiDelegate?
   
   let requestJson = """
{
    "area": "Tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""
    func setWeatherType() {
        do{
            
            let fetchWeatherCondition = try YumemiWeather.fetchWeather(requestJson)
            
            guard let jsonData = fetchWeatherCondition.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                  let maxTemperature = json["max_temperature"] as? Int,
                  let minTemperature = json["min_temperature"] as? Int,
                  let fetchWeatherCondition = json["weather_condition"] as? String
            else{ return
            }
            delegate?.setWeatherType(type: fetchWeatherCondition)
            delegate?.setmaxTemperature(max: maxTemperature)
            delegate?.setminTemperature(min: minTemperature)
        }catch{
        delegate?.setWeatherError(alert: "エラー1111")
        
        }
    }
}



















