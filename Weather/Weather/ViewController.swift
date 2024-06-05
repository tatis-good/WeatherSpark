//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/05/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let weatherDelegate = WeatherDelegate()
    var weatherArea:AreaResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        
        showData()
    }
    func showData() {
        var weatherString = "sunny"
        var tintcolor = UIColor.red
        guard let weatherArea = self.weatherArea else {
            return }
            
            DispatchQueue.global().async {
                switch  weatherArea.info.fetchWeatherCondition {
                case "sunny":
                    weatherString = "sunny"
                    tintcolor = UIColor.red
                case "cloudy":
                    weatherString = "cloudy"
                    tintcolor = UIColor.gray
                case "rainy":
                    weatherString = "rainy"
                    tintcolor = UIColor.blue
                default:
                    break
                }
            }
            DispatchQueue.main.async{
                self.weatherImage.image = UIImage(named: weatherString)
                self.weatherImage.tintColor = tintcolor
                
                self.maxLabel.text = String(weatherArea.info.maxTemperature)
                self.minLabel.text = String(weatherArea.info.minTemperature)
            }
        
    }
    
    @IBAction func ReloadBtn(_ sender: Any) {
        reloadWeather()
    }
    
    func reloadWeather() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.weatherDelegate.setWeatherType { result in
                switch result {
                case .success(let weather):
                    self.setWeather(weather: weather)
                case .failure(let error):
                    self.setWeatherError(alert: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
       dismiss(animated: true)
    }
    
    
    
    func setWeather(weather: Weather) {
        var weatherString = weather.fetchWeatherCondition
        var tintcolor = UIColor.red
        
        DispatchQueue.global().async {
            switch  weatherString {
            case "sunny":
                weatherString = "sunny"
                tintcolor = UIColor.red
            case "cloudy":
                weatherString = "cloudy"
                tintcolor = UIColor.gray
            case "rainy":
                weatherString = "rainy"
                tintcolor = UIColor.blue
            default:
                break
            }
        }
        DispatchQueue.main.async{
            self.weatherImage.image = UIImage(named: weatherString)
            self.weatherImage.tintColor = tintcolor
            
            self.maxLabel.text = String(weather.maxTemperature)
            self.minLabel.text = String(weather.minTemperature)
            self.indicator.stopAnimating()
        }
    }
    
    func setWeatherError(alert: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: alert, message: "時間を置いてもう一度お試しください", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alertController, animated: true, completion: nil)
            self.indicator.stopAnimating()
        }
    }
}


