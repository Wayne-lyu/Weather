//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var tableView: UITableView!
    var list: [DataPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {

        navigationItem.title = "Week"

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
    }

}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellIdentifier")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.string(from: list[indexPath.row].time)
        let summary = list[indexPath.row].summary
        cell.textLabel?.text =  "\(date)  \(summary!)"
        return cell
    }
    
}
