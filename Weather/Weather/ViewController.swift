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
    func setWeatherType(type: String) {
        
        var weather = "sunny"
        var tintcolor = UIColor.red
        
        switch type {
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
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setmaxTemperature(max: Int) {
        self.maxLabel.text = String(max)
    }
    
    func setminTemperature(min: Int) {
        self.minLabel.text = String(min)
    }
    
    
    func setWeatherError(alert: String){
        let alertController = UIAlertController(title: alert, message: "時間を置いてもう一度お試しください", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}









