//
//  WeatherService .swift
//  WetherGB
//
//  Created by Maxim Bekmetov on 25.10.2021.
//

import UIKit
import Alamofire
import RealmSwift

class WeatherService {
    // базовый URL сервиса
    let baseUrl = "http://api.openweathermap.org"
    // ключ для доступа к сервису
    let apiKey = "dde46d07224f389c0a58b77a6334998a"
    
    // метод для загрузки данных, в качестве аргументов получает город
        func loadWeatherData(city: String, completion: @escaping () -> Void ){
    // путь для получения погоды за 5 дней
            let path = "/data/2.5/forecast"
    // параметры, город, единицы измерения (градусы), ключ для доступа к сервису
            let parameters: Parameters = [
                "q": city,
                "units": "metric",
                "appid": apiKey
            ]
    // составляем URL из базового адреса сервиса и конкретного пути к ресурсу
            let url = baseUrl+path
    // делаем запрос
            AF.request(url, method: .get, parameters: parameters).responseData { [weak self] repsons in
                guard let data = repsons.value else { return }
                
                let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
               // weather.forEach { $0.city = city }
                
                self?.saveWeatherData(weather, city: city)
                
                completion()
            }
        }
    
    //    // метод для загрузки данных, в качестве аргументов получает город
    //    func loadWeatherData(city: String, completion: @escaping ([Weather]) -> Void ){
    //
    //        // путь для получения погоды за 5 дней
    //        let path = "/data/2.5/forecast"
    //        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
    //        let parameters: Parameters = [
    //            "q": city,
    //            "units": "metric",
    //            "appid": apiKey
    //        ]
    //
    //        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
    //        let url = baseUrl+path
    //
    //        // делаем запрос
    //        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] repsons in
    //            guard let data = repsons.value else { return }
    //
    //            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
    //
    //
    //            self?.saveWeatherData(weather)
    //
    //            completion(weather)
    //        }
    //
    //    }
    
    // сохранение погодных данных в realm
    func saveWeatherData(_ weathers: [Weather], city: String) {
        // обработка исключений при работе с хранилищем
        do {
            // получаем доступ к хранилищу
            let realm = try Realm()
            
            // все старые погодные данные для текущего города
            let oldWeathers = realm.objects(Weather.self).filter("city == %@", city)
            
            // начинаем изменять хранилище
            realm.beginWrite()
            
            // удаляем старые данные
            realm.delete(oldWeathers)
            
            // кладем все объекты класса погоды в хранилище
            realm.add(weathers)
            
            // завершаем изменение хранилища
            try realm.commitWrite()
        } catch {
            // если произошла ошибка, выводим ее в консоль
            print(error)
        }
    }
}
