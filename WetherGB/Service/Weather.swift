//
//  Weather.swift
//  WetherGB
//
//  Created by Maxim Bekmetov on 25.10.2021.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Weather: Object {
    @objc dynamic var date = 0.0
    @objc dynamic var temp = 0.0
    @objc dynamic var pressure = 0.0
    @objc dynamic var humidity = 0
    @objc dynamic var weatherName = ""
    @objc dynamic var weatherIcon = ""
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDegrees = 0.0
    @objc dynamic var city = ""
    
    convenience init(json: JSON) {
        self.init()
        
        self.date = json["dt"].doubleValue
        self.temp = json["main"]["temp"].doubleValue
        self.pressure = json["main"]["pressure"].doubleValue
        self.humidity = json["main"]["humidity"].intValue
        self.weatherName = json["weather"][0]["main"].stringValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
        self.windSpeed = json["wind"]["speed"].doubleValue
        self.windDegrees = json["wind"]["deg"].doubleValue
        self.city = city
        
    }
}

//class Weather: Object, Decodable {
//    @objc dynamic var date = 0.0
//    @objc dynamic var temp = 0.0
//    @objc dynamic var pressure = 0.0
//    @objc dynamic var humidity = 0
//    @objc dynamic var weatherName = ""
//    @objc dynamic var weatherIcon = ""
//    @objc dynamic var windSpeed = 0.0
//    @objc dynamic var windDegrees = 0.0
//    var city = ""
//
//    enum CodingKeys: String, CodingKey {
//        case date = "dt"
//        case main
//        case weather
//        case wind
//    }
//
//    enum MainKeys: String, CodingKey {
//        case temp
//        case pressure
//        case humidity
//    }
//
//    enum WeatherKeys: String, CodingKey {
//        case main
//        case icon
//    }
//
//    enum WindKeys: String, CodingKey {
//        case speed
//        case deg
//    }
//
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.date = try values.decode(Double.self, forKey: .date)
//
//        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
//        self.temp = try mainValues.decode(Double.self, forKey: .temp)
//        self.pressure = try mainValues.decode(Double.self, forKey: .pressure)
//        self.humidity = try mainValues.decode(Int.self, forKey: .humidity)
//
//        var weatherValues = try values.nestedUnkeyedContainer(forKey: .weather)
//        let firstWeatherValues = try weatherValues.nestedContainer(keyedBy: WeatherKeys.self)
//        self.weatherName = try firstWeatherValues.decode(String.self, forKey: .main)
//        self.weatherIcon = try firstWeatherValues.decode(String.self, forKey: .icon)
//
//        let windValues = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
//        self.windSpeed = try windValues.decode(Double.self, forKey: .speed)
//        self.windDegrees = try windValues.decode(Double.self, forKey: .deg)
//    }
//
//}


