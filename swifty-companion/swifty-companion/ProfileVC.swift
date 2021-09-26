//
//  ProfileVC.swift
//  swifty-companion
//
//  Created by Yassir Bolles on 9/20/21.
//  Copyright © 2021 Yassir Bolles. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileVC: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var FullName: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var crrection: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var cursus: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var ProjectsTable: UITableView!
    @IBOutlet weak var SkillsTable: UITableView!
    var userInfosData: JSON?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        userAvatar.layer.cornerRadius = userAvatar.frame.size.width / 2
        userAvatar.clipsToBounds = true
        userAvatar.layer.borderWidth = 2
        userAvatar.layer.masksToBounds = true
        userAvatar.layer.borderColor = UIColor.white.cgColor
        userAvatar.layer.cornerRadius = userAvatar.frame.height / 2
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        progressBar.layer.cornerRadius = progressBar.frame.height / 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = progressBar.frame.height / 2
        progressBar.subviews[1].clipsToBounds = true
        ProjectsTable.clipsToBounds = true
        ProjectsTable.layer.cornerRadius = 5
        SkillsTable.clipsToBounds = true
        SkillsTable.layer.cornerRadius = 5
        ProjectsTable.separatorStyle = .none
        ProjectsTable.dataSource = self
       
        printData()
        print("******")
        print(userInfosData!["projects_users"] as Any)
    }

    func printData(){
     
        let strUrl = userInfosData!["image_url"].string
        if let url = URL(string: strUrl!) {
                  
               
        if let data = NSData(contentsOf: url) {
                       userAvatar.image = UIImage(data: data as Data)
                   }
        }
        if let value = userInfosData!["displayname"].string {
                  FullName.text = value
        }
        if let value = userInfosData!["login"].string {
                  login.text = value
        }
        if let value = userInfosData!["location"].string {
            location.text = "Available\n\(value)"
        }
        else
        {
            location.text = "Unavailable\n-"
        }
        
        if let value = userInfosData!["wallet"].int {
            wallet.text = "Wallet: \(value)₳"
        }
        if let value = userInfosData!["correction_point"].int {
            crrection.text = "Correction: \(value)"
        }
        if userInfosData!["cursus_users"].count > 2 {
            if let value = userInfosData!["cursus_users"][2]["grade"].string {
                grade.text = "Grade: \(value)"
            }
            if let value = userInfosData!["cursus_users"][2]["cursus"]["name"].string {
                cursus.text = "Cursus: \(value)"
            }
            if let value = userInfosData!["cursus_users"][2]["level"].float {
                level.text = "Level: \(Int(value)) - \(Int(modf(value).1 * 100))%"
                progressBar.progress = modf(value).1
            }
        } else {
            if let value = userInfosData!["cursus_users"][0]["grade"].string {
                grade.text = "Grade: \(value)"
            }
            if let value = userInfosData!["cursus_users"][0]["cursus"]["name"].string {
                cursus.text = "Cursus: \(value)"
            }
            if let value = userInfosData!["cursus_users"][0]["level"].float {
                level.text = "Level: \(Int(value)) - \(Int(modf(value).1 * 100))%"
                progressBar.progress = modf(value).1
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return userInfosData!["projects_users"].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTable") as! ProfileTVC
            let Projects = userInfosData!["projects_users"][indexPath.row]
        cell.name.text = "salam"
        cell.grade.text = "50"
            return cell
     
    }
}
