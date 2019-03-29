//
//  WeatherListViewController.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit

class WeatherListViewController: UIViewController {

    private var tableView: UITableView!
    private var list: [String] = ["LA", "SH"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    @objc private func didTapDone() {
        print("locating")
    }

    private func setupUI() {

        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forecast", style: .plain, target: self, action: #selector(didTapDone))

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CompactTableViewCell.self, forCellReuseIdentifier: "CompactCell")
        tableView.register(RichTableViewCell.self, forCellReuseIdentifier: "RichCell")

        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
    }

}

extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CompactCell", for: indexPath) as!
            CompactTableViewCell
        cell.titleLabel.text = list[indexPath.row]
        cell.subTitleLabel.text = "100"

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
}
