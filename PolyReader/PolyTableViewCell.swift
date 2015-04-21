//
//  PolyTableViewCell.swift
//  PolyReader
//
//  Created by Rean on 4/21/15.
//  Copyright (c) 2015 Rean. All rights reserved.
//

import UIKit

class PolyTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newsTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateImage(image: UIImage, frame: CGRect){
        
    }

}
