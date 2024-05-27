//
//  weather.swift
//  Weather
//
//  Created by spark-02 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol YumemiDelegate {
    func ymmWeather(type: String)
    func showAlert(alert: String)
    }

class WeatherDelegate {
    var delegate: YumemiDelegate?
   
   let requestJson = """
{
    "area": "Tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""
    
    
    
    func yumemiDate() {
        do{
            let fetchWeatherString = try YumemiWeather.fetchWeather(requestJson)
            delegate?.ymmWeather(type: fetchWeatherString)
        }catch{
        delegate?.showAlert(alert: "エラー1111")
        }
    }
}
