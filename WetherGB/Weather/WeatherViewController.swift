//
//  WeatherCollectioCollectionViewController.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 27.04.2021.
//

import UIKit

class WeatherViewController: UICollectionViewController {
    
    // массив с погодой
    var weathers = [Weather]()
    // создаем экземпляр сервиса
    let weatherService = WeatherService()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // отправим запрос для получения погоды в Москве
        weatherService.loadWeatherData(city: "Moscow") { [weak self] weathers in
            // сохраняем полученные данные в массиве, чтобы коллекция могла получить к ним доступ
            self?.weathers = weathers
            // коллекция должна прочитать новые данные
            self?.collectionView?.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseID, for: indexPath) as! WeatherCell
        
        cell.configure(whithWeather: weathers[indexPath.row])
        
        return cell
    }
    
}
