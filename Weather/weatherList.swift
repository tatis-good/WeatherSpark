//
//  weatherList.swift
//  Weather
//
//  Created by spark-02 on 2024/06/03.
//

import Foundation
import YumemiWeather
import UIKit

class weatherList {
    func listData(completion: @escaping(Result<[AreaResponse],Error>) -> Void) {
        DispatchQueue.global().async {
            let date = Date().ISO8601Format()
            let sendJsonString = List(areas: [],date: date)
            
            do{
                let encoder = JSONEncoder()
                let jsonDate = try encoder.encode(sendJsonString)
                guard let requestJson = String(data: jsonDate, encoding: .utf8)
                else {return
                }
                
                let fetchWeatherCondition = try YumemiWeather.syncFetchWeatherList(requestJson)
                guard let jsonData = fetchWeatherCondition.data(using: .utf8) else{
                    return
                }
                
                let decorer = JSONDecoder()
                let weather  = try decorer.decode([AreaResponse].self, from: jsonData)
                
                completion(.success(weather))
            }  catch  {
                completion(.failure(error))
            }
        }
    }
}
