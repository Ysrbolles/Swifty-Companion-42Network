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


}


class SkillsTVC: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var SkillProgress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SkillProgress.transform = SkillProgress.transform.scaledBy(x: 1, y: 2)
        SkillProgress.layer.cornerRadius = SkillProgress.frame.height / 2
        SkillProgress.clipsToBounds = true
        SkillProgress.layer.sublayers![1].cornerRadius = SkillProgress.frame.height / 2
        SkillProgress.subviews[1].clipsToBounds = true
    }

}
