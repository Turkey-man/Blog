//
//  Networking.swift
//  AlamofireTesting
//
//  Created by 1 on 3/17/19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Alamofire

public class Network {
    public static func getTokenBy() {
        request("https://storm.ualegion.com/api/v1/security/auth/login", method: .post, parameters: ["login" : "fed", "password" : "1234567a"], encoding: JSONEncoding.default).responseData { response in
            let json = response.data
            do {
                let data = try JSONDecoder().decode(Login.self, from: json!)
//                print("NEW DATA")
//                print(data.token)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public static func getData<T: Decodable>(completionHandler: @escaping (T) -> Void) {
        let token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyIiwiZXhwIjoxNTUzNDYyODA3LCJyYW5kb20iOjU4ODMsInJvbGUiOiJST0xFX0NMSUVOVCJ9.kjarz6dGLvgLureFE19C24wXIVGi1n80Q9h7XrOuDINGPk51lsO0J3-gH9hrU_Fz_qR7ZEvPbmbmO1YwhxE5iw"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        request("https://storm.ualegion.com/api/v1/projects/my", method: .get, encoding: JSONEncoding.default, headers: headers).responseData { response in
            let json = response.data
//            print("JSON")
//            print(json)
            goToNetwork(json: json!, completionHandler: completionHandler)
        }
    }
    
    public static func goToNetwork<T: Decodable>(json: Data, completionHandler: @escaping (T) -> Void) {
        do {
            let data = try JSONDecoder().decode(T.self, from: json)
            DispatchQueue.main.async {
                completionHandler(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
