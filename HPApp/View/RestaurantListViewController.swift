//
//  ViewController.swift
//  HPApp
//
//  Created by 坂馬啓太 on 2021/08/29.
//

import UIKit
import Alamofire
import CoreLocation

class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var restaurantListCollectionView: UICollectionView!
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var rangeSegmentedControl: UISegmentedControl!
    var locationManager: CLLocationManager?
    var latitude: String = ""
    var longitude: String = ""
    var searchWord: String = ""
    var range: String = ""
    
    private let cellId = "cellId"
    private var shopInfos = [Shop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantListCollectionView.delegate = self
        restaurantListCollectionView.dataSource = self
        searchText.delegate = self
        
        restaurantListCollectionView.register(UINib(nibName: "RestaurantListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        locationSet()
        placeHolderText()
        rangeChanged(rangeSegmentedControl)
    }
    
    
    private func fetchHotPepperSearchInfo(){
        
        guard let searchWordEncode = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let urlString = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=0c50218b6f7890e5&format=json&count=100&keyword=\(searchWordEncode)&lat=\(latitude)&lng=\(longitude)&range=\(range)"
        
        let request = AF.request(urlString)
        
        request.responseJSON{ (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let restaurant = try decode.decode(Restaurant.self, from: data)
                self.shopInfos = restaurant.results.shop
                self.restaurantListCollectionView.reloadData()
                
            } catch {
                print("変換に失敗しました。;", error)
            }
        }
    }
    
    private func locationSet() {
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.distanceFilter = 10
            locationManager!.activityType = .fitness
            locationManager!.startUpdatingLocation()
        }
    }
    
    private func placeHolderText() {
        searchText.delegate = self
        searchText.placeholder = "キーワードを入力してください"
    }
    @IBAction func rangeChanged(_ sender: UISegmentedControl) {
        let index = rangeSegmentedControl.selectedSegmentIndex
        self.range = String(index + 1)
        print(range)
        fetchHotPepperSearchInfo()
    }
}


extension RestaurantListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = restaurantListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantListCell
        cell.shopInfo = shopInfos[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantViewController = UIStoryboard(name: "RestaurantView", bundle: nil).instantiateViewController(identifier: "RestaurantViewController") as RestaurantViewController
        restaurantViewController.selectedShopInfo = shopInfos[indexPath.row]
        
        self.present(restaurantViewController, animated: true, completion: nil)
    }
}

extension RestaurantListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        
        self.latitude = String(location.latitude)
        self.longitude = String(location.longitude)
        
        fetchHotPepperSearchInfo()
    }
}
extension RestaurantListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        if let searchWord = searchBar.text {
            self.searchWord = searchWord
            fetchHotPepperSearchInfo()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
            searchBar.setShowsCancelButton(true, animated: true)
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
        }
}
