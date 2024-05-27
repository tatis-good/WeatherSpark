//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/05/22.
//

import UIKit


class ViewController: UIViewController, YumemiDelegate {
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    let weatherDelegate = WeatherDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDelegate.delegate = self
    }
    
    @IBAction func ReloadBtn(_ sender: Any) {
        weatherDelegate.yumemiDate()
      
    }
       func ymmWeather(type: String) {
            
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
    func showAlert(alert: String){
    let alertController = UIAlertController(title: alert, message: "時間を置いてもう一度お試しください", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
}))
    self.present(alertController, animated: true, completion: nil)
}
    }

