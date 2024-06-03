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
    let areas = List(areas: [String])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return areas.count
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =
        return cell
    }


}
