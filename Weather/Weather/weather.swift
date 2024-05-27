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
            delegate?.setWeatherType(type: fetchWeatherCondition)
        }catch{
        delegate?.setWeatherError(alert: "エラー1111")
        }
    }
}



















