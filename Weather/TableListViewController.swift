//
//  TableListViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/06/03.
//

import UIKit

class TableListViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let WeatherList = weatherList()
    var areas : [AreaResponse] = []
    var refreshControl:UIRefreshControl!
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        selectWeather()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "再読み込み中")
        refreshControl.addTarget(self, action: #selector(TableListViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func updateData () {
        DispatchQueue.global().async {
            
            self.selectWeather()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.semaphore.signal()
            }
        }
    }
    
    @objc func refresh() {
        updateData()
        
        semaphore.wait()
        semaphore.signal()
        
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                tableView.deselectRow(at: indexPath, animated: animated)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath)
        let area = areas[indexPath.row]
        cell.textLabel?.text = area.area.rawValue
        let maxTem = area.info.maxTemperature
        let minTem = area.info.minTemperature
        cell.detailTextLabel?.text = "最高気温:\(maxTem)度,最低気温:\(minTem)度"
        
        switch area.info.fetchWeatherCondition {
        case "sunny":
            cell.imageView?.image = UIImage(named: "sunny")
            cell.imageView?.tintColor = UIColor.red
        case "cloudy":
            cell.imageView?.image = UIImage(named: "cloudy")
            cell.imageView?.tintColor = UIColor.gray
        case "rainy":
            cell.imageView?.image = UIImage(named: "rainy")
            cell.imageView?.tintColor = UIColor.blue
        default:
            break
        }
        return cell
    }
    
    func selectWeather() {
        self.WeatherList.listData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.areas = success
                    self.tableView.reloadData()
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
        if segue.identifier == "sendDetail",
           let IndexPath = tableView.indexPathForSelectedRow {
            if let cellSegue = segue.destination as? ViewController {
                cellSegue.weatherArea = areas[IndexPath.row]
            }
        }
    }
}

