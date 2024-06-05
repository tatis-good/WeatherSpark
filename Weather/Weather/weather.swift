//
//  weather.swift
//  Weather
//
//  Created by spark-02 on 2024/05/24.
//

import Foundation
import YumemiWeather



class WeatherDelegate {
    
    
    
    func setWeatherType(completion: @escaping(Result<Weather,Error>) -> Void) {
        DispatchQueue.global().async {
            let sendJsonString = WeatherDate(area: "tokyo",date: "2020-04-01T12:00:00+09:00")
            
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
                
                
                
                completion(.success(weather))
            }  catch  {
                completion(.failure(error))
                
            }
        }
    }
}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

