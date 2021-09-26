//
//  ProfileTVC.swift
//  swifty-companion
//
//  Created by Yassir Bolles on 9/26/21.
//  Copyright © 2021 Yassir Bolles. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
