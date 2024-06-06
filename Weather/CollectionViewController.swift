//
//  CollectionViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/06/06.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectView: UICollectionView!
    
    let WeatherList = weatherList()
    var areas : [AreaResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectView.dataSource = self
        collectView.delegate = self
        selectWeather()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell" , for: indexPath) as? CollectionViewCell else {
            let errorCell = UICollectionViewCell()
            return errorCell
        }
        let area = areas[indexPath.row]
        switch area.info.fetchWeatherCondition {
        case "sunny":
            cell.collectImage.image = UIImage(named: "sunny")
            cell.collectImage.tintColor = UIColor.red
        case "cloudy":
            cell.collectImage.image = UIImage(named: "cloudy")
            cell.collectImage.tintColor = UIColor.gray
        case "rainy":
            cell.collectImage.image = UIImage(named: "rainy")
            cell.collectImage.tintColor = UIColor.blue
        default:
            break }
        return cell
    }
    
    func selectWeather() {
        self.WeatherList.listData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.areas = success
                    self.collectView.reloadData()
                case .failure(let error):
                    self.setWeatherError(alert: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setWeatherError(alert: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: alert, message: "時間を置いてもう一度お試しください", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "リトライ", style: .default, handler: { action in
                self.selectWeather() }))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectSegue",
           let IndexPath = collectView.indexPathsForSelectedItems?.first {
            if let cellSegue = segue.destination as? ViewController {
                cellSegue.weatherArea = areas[IndexPath.row]
            }
        }
    }
}

