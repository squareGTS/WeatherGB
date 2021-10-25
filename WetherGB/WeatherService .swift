//
//  WeatherService .swift
//  WetherGB
//
//  Created by Maxim Bekmetov on 25.10.2021.
//

import UIKit
import Alamofire

class WeatherService {
    // базовый URL сервиса
    let baseUrl = "http://api.openweathermap.org"
    // ключ для доступа к сервису
    let apiKey = "dde46d07224f389c0a58b77a6334998a"
    
    // метод для загрузки данных, в качестве аргументов получает город
    func loadWeatherData(city: String, completion: @escaping ([Weather]) -> Void ){
        
        // путь для получения погоды за 5 дней
        let path = "/data/2.5/forecast"
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            completion(weather)
        }
    }
}
