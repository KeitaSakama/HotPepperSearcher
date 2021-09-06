//
//  Restaurant.swift
//  HPApp
//
//  Created by 坂馬啓太 on 2021/08/29.
//

import Foundation

class Restaurant: Codable {
    let results: Results
}
class Results: Codable {
    let shop: [Shop]
}
class Shop: Codable {
    
    let access: String
    let open: String
    let address: String
    let name: String
    let lat: Double
    let lng: Double
    let photo: Photo
    let genre: Genre
    let urls: Urls
}
class Photo: Codable {
    let mobile: Mobile
}
class Mobile: Codable {
    let l: String
}
class Genre: Codable {
    let name: String
}
class Urls: Codable {
    let pc: String
}

