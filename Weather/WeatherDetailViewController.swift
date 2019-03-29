//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var tableView: UITableView!
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Detail"

        tableView = UITableView(frame:CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.white
    }

}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
    
}
