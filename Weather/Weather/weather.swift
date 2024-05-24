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
    }

class WeatherDelegate {
    var delegate: YumemiDelegate?
    
    func yumemiDate() {
        
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        delegate?.ymmWeather(type: fetchWeatherString)
        
    
        
    }
}
