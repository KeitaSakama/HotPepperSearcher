//
//  RestaurantListCell.swift
//  HPApp
//
//  Created by 坂馬啓太 on 2021/08/29.
//

import UIKit
import Nuke

class RestaurantListCell: UICollectionViewCell {
    
    var shopInfo: Shop? {
        didSet{
            
            if let url = URL(string: shopInfo?.photo.mobile.l ?? ""){

                Nuke.loadImage(with: url, into: photoImageView)
            }
            
            titleLabel.text = shopInfo?.name
            addressLabel.text = shopInfo?.address
            genreLabel.text = shopInfo?.genre.name
      
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
    }
 
}
