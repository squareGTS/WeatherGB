//
//  WeatherResponse.swift
//  WetherGB
//
//  Created by Maxim Bekmetov on 25.10.2021.
//

import UIKit

class WeatherResponse: Decodable {
    let list: [Weather]
}
