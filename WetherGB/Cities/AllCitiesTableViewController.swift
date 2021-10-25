//
//  AllCitiesTableViewController.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class AllCitiesTableViewController: UITableViewController {

	var cities = ["Paris", "Vladivostok", "Rostov"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.reuseIdentifier, for: indexPath) as! CitiesTableViewCell

		let city = cities[indexPath.row]
		cell.configure(title: city, image: UIImage(systemName: "bolt"))
        return cell
    }
}
