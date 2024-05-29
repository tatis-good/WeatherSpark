//
//  weather.swift
//  Weather
//
//  Created by spark-02 on 2024/05/24.
//

import Foundation
import YumemiWeather




protocol YumemiDelegate {
    func setWeatherError(alert: String)
    func setWeather(weather: Weather)
    }

class WeatherDelegate {
    var delegate: YumemiDelegate?
    
    

    func setWeatherType() {
        DispatchQueue.global().async {
            let sendJsonString = Date(area: "tokyo",date: "2020-04-01T12:00:00+09:00")
            
            do{
                let encoder = JSONEncoder()
                let jsonDate = try encoder.encode(sendJsonString)
                guard let requestJson = String(data: jsonDate, encoding: .utf8)
                else {return
                }
                
                let fetchWeatherCondition = try YumemiWeather.syncFetchWeather(requestJson)
                guard let jsonData = fetchWeatherCondition.data(using: .utf8) else{
                    return
                }
                let decorer = JSONDecoder()
                let weather  = try decorer.decode(Weather.self, from: jsonData)
                
                self.delegate?.setWeather(weather: weather)
            }catch{
                self.delegate?.setWeatherError(alert: "エラー1111")
                
            }
        }
    }
}



















