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
    
    func yumemiDate() {
        do{
            let fetchWeatherString = try YumemiWeather.fetchWeatherCondition(at: "")
            delegate?.ymmWeather(type: fetchWeatherString)
        }catch{
        delegate?.showAlert(alert: "エラー1111")
        }
    
        
    }
}
