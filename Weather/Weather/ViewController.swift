//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/05/22.
//

import UIKit


class ViewController: UIViewController, YumemiDelegate {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    let weatherDelegate = WeatherDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDelegate.delegate = self
    }
    
    @IBAction func ReloadBtn(_ sender: Any) {
        weatherDelegate.setWeatherType()
    }
    func setWeather(weather: Weather) {
        
        var weatherString = weather.fetchWeatherCondition
        var tintcolor = UIColor.red
        
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
        weatherImage.image = UIImage(named: weatherString)
        weatherImage.tintColor = tintcolor
        
        self.maxLabel.text = String(weather.maxTemperature)
        self.minLabel.text = String(weather.minTemperature)
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    func setWeatherError(alert: String){
        let alertController = UIAlertController(title: alert, message: "時間を置いてもう一度お試しください", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}









