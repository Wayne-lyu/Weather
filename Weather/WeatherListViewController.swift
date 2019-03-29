//
//  WeatherListViewController.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit
import Alamofire

class WeatherListViewController: UIViewController {

    private var tableView: UITableView!
    private var list: [String] = ["LA", "SH"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    @objc private func didTapDone() {
        Alamofire.request("https://api.darksky.net/forecast/c3058f0521895f96e24491029a21f763/42.3601,-71.0589")
            .responseData { response in

                switch response.result {
                case let .success(data):
                    let decoder = JSONDecoder()
                    let weather = try? decoder.decode(Forecast.self, from: data)
                    print(weather?.latitude ?? 0)
                case let .failure(error):
                    dump(error)
                }
        }
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
