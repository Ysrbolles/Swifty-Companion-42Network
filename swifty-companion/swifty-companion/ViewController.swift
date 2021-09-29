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

    

    @IBOutlet weak var Searchbtn: UIButton!
    @IBOutlet weak var LoginText: UITextField!
    var userInfos: JSON?
    let Api = API(Url: "https://api.intra.42.fr/oauth/token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Api.getToken()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let Login = LoginText.text?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                        if  Login != "" {
                            let loaderAlert = self.loader()
                           Api.getUser(login: Login!) {
                            completion in
                            if completion != nil && completion!.count > 0{
                                    self.userInfos = completion
                                    self.StopLoader(load: loaderAlert)
                                    self.performSegue(withIdentifier: "Profile", sender: self)
                                    self.Searchbtn.isEnabled = true
                                    self.LoginText.text = ""
                                } else {
                               
                               loaderAlert.dismiss(animated: true){
                                        let alert = UIAlertController(title: "Error", message: "This login doesn't exists", preferredStyle: UIAlertController.Style.alert)
                                                                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                  self.present(alert, animated: true, completion: nil)
                                                                  self.Searchbtn.isEnabled = true
                                                                  self.LoginText.text = nil
                               }
                                 
                                }
                            }
                        }
                        else {
                            let alert = UIAlertController(title: "Error", message: "Login should not be empty", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            self.Searchbtn.isEnabled = true
                            self.LoginText.text = nil
                          
                        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Profile") {
                    guard let ProfileVC =  segue.destination as? ProfileVC else { return }
                    ProfileVC.userInfosData = self.userInfos
        }
    }
    
    
    //Loader for data
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Pleas Wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func StopLoader(load: UIAlertController){
        DispatchQueue.main.async {
            load.dismiss(animated: true, completion: nil)
        }
    }
}
