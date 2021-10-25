//
//  WeatherCollectionViewCell.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    static let reuseID = "WeatherCell"
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    func configure(whithWeather weather: Weather) {
        let date = Date(timeIntervalSince1970: weather.date)
        let stringDate = WeatherCell.dateFormatter.string(from: date)
        
        self.weather.text = String(weather.temp)
        time.text = stringDate
        icon.image = UIImage(named: weather.weatherIcon)
    }
}
