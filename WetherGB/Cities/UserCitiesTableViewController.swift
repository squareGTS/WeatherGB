//
//  UserCitiesTableViewController.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class UserCitiesTableViewController: UITableViewController {

	var cities = ["Moscow", "Krasnodar", "London", "Rome"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard
			segue.identifier == "WeatherSegue",
			let destinationController = segue.destination as? WeatherViewController,
			let index = tableView.indexPathForSelectedRow?.row
		else {
			return
		}

		destinationController.title = cities[index]
	}

	@IBAction func addCity(segue: UIStoryboardSegue) {
		guard
			segue.identifier == "AddCity",
			let sourceController = segue.source as? AllCitiesTableViewController,
			let index = sourceController.tableView.indexPathForSelectedRow
		else {
			return
		}

		let city = sourceController.cities[index.row]

		if !cities.contains(city) {
			cities.append(city)
		}
		tableView.reloadData()
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

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		// Если была нажата кнопка «Удалить»
		if editingStyle == .delete {
			// Удаляем город из массива
			cities.remove(at: indexPath.row)
			// И удаляем строку из таблицы
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}

}
