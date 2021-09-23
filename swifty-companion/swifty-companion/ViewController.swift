//
//  ViewController.swift
//  swifty-companion
//
//  Created by Yassir Bolles on 9/20/21.
//  Copyright © 2021 Yassir Bolles. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var LoginText: UITextField!
    @IBOutlet weak var Searchbtn: UIButton!
    var userInfos: JSON?
    let Api = API(Url: "https://api.intra.42.fr/oauth/token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Api.getToken()
        // Do any additional setup after loading the view.
    }
 
  
    @IBAction func loginCheck(_ sender: UITextField) {
        if sender.text != ""
        {
            Searchbtn.isEnabled = true
            Searchbtn.backgroundColor = UIColor.blue
        }
        else
        {
            Searchbtn.isEnabled = false
            Searchbtn.backgroundColor = UIColor.gray
        }
    }
    @IBAction func Search(_ sender: Any) {
        if let login = LoginText.text?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil) {
        Api.getUser(login: login) {
            completion in
                if completion != nil {
                    self.userInfos = completion
                    self.performSegue(withIdentifier: "Profile", sender: nil)
                    self.Searchbtn.isEnabled = true
                } else {
                   print("khrya")
                  
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Profile") {
                    guard let ProfileVC =  segue.destination as? ProfileVC else { return }
                    ProfileVC.userInfosData = self.userInfos
        }
    }

}
