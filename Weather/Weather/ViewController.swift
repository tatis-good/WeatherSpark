//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/05/22.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ReloadBtn(_ sender: Any) {
        setWeather()
        
    }
    func setWeather() {
        
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
       
        
       var weather = "sunny"
        var tintcolor = UIColor.red
        
        switch fetchWeatherString {
        case "sunny":
            weather = "sunny"
            tintcolor = UIColor.red
        case "cloudy":
            weather = "cloudy"
            tintcolor = UIColor.gray
        case "rainy":
            weather = "rainy"
            tintcolor = UIColor.blue
        default:
            break
        }
        weatherImage.image = UIImage(named: weather)
        weatherImage.tintColor = tintcolor
    }

}
