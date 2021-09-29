//
//  API.swift
//  swifty-companion
//
//  Created by Yassir Bolles on 9/21/21.
//  Copyright © 2021 Yassir Bolles. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API {
    
    private var Url = ""
    private let config = ["grant_type":  "client_credentials", "client_id":  "c006f18f30eac2d09afa452c71072325ef1728da7d56ad63ce46570707557749", "client_secret": "31d230cd5a12e461c100ba26ece392347051bcca90978925f0b76b3fc246a61d" ]
    private var token = ""
    
    init(Url: String) {
        self.Url = Url
    }
    
    private func checkToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        AF.request(request as URLRequestConvertible).validate().responseJSON {
            response
            in switch response.result {
            case .success(let response):
                let json = JSON(response)
                print("The token will expire in:", json["expires_in_seconds"], "seconds.")
            case .failure(let error):
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    func getToken() {
        let verifyToken = UserDefaults.standard.object(forKey: token)
        if verifyToken == nil {
            AF.request(Url, method: .post, parameters: config).responseJSON {
                     response
                     in switch response.result {
                     case .success(let JSON):
                        let response = JSON as! NSDictionary
                        self.token = response.object(forKey: "access_token") as! String
                        UserDefaults.standard.set(self.token, forKey: "token")
                        self.checkToken()
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                 }
        } else {
            checkToken()
        }
    }
    func getUser(login username:String, completion: @escaping (JSON?) -> Void){
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + username)
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        AF.request(request as URLRequestConvertible).responseJSON {
                   response
                   in switch response.result {
                               case .success(let response):
                                let json = JSON(response)
                                   completion(json)

                               case .failure(let error):
                                   print("Request failed with error: \(error)")
                               }
               }
    }
}

