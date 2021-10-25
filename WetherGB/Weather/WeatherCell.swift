//
//  WeatherCollectionViewCell.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class WeatherCell: UICollectionViewCell {

	static let reuseID = "WeatherCollectionViewCell"

	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!

}
