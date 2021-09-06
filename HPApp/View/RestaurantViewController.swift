//
//  RestaurantViewController.swift
//  HPApp
//
//  Created by 坂馬啓太 on 2021/09/06.
//

import UIKit
import Nuke

class RestaurantViewController: UIViewController {

    var selectedShopInfo: Shop?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: selectedShopInfo?.photo.mobile.l ?? ""){

            Nuke.loadImage(with: url, into: photoImageView)
        }
        
        titleLabel.text = selectedShopInfo?.name
        addressLabel.text = selectedShopInfo?.address
        genreLabel.text = selectedShopInfo?.genre.name
        accessLabel.text = selectedShopInfo?.access
        hoursLabel.text = selectedShopInfo?.open
    }
}


