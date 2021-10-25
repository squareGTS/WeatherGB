//
//  CitiesTableViewCell.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

	static let reuseIdentifier = "CitiesTableViewCell"

	@IBOutlet weak var titleCell: UILabel!
	@IBOutlet weak var imageViewCell: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
    }

	func configure(title: String?, image: UIImage?) {
		titleCell.text = title
		imageViewCell.image = image
	}
}
