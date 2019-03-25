//
//  Network.swift
//  AlamofireTesting
//
//  Created by 1 on 3/17/19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Alamofire
//"eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyIiwiZXhwIjoxNTUzNDYyODA3LCJyYW5kb20iOjU4ODMsInJvbGUiOiJST0xFX0NMSUVOVCJ9.kjarz6dGLvgLureFE19C24wXIVGi1n80Q9h7XrOuDINGPk51lsO0J3-gH9hrU_Fz_qR7ZEvPbmbmO1YwhxE5iw"
public class Network {
    private static let baseUrl = "https://storm.ualegion.com/api/v1/"
    private static let loginUrl = "security/auth/login"
    private static let parameters = ["login" : "reader", "password" : "1234567a"]
    private static let gerRequestUrl = "projects/my"
    private static let storage = Storage()
    
    public static func getToken<T: Decodable>(completionHandler: @escaping (T) -> Void) {
        request(baseUrl + loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            let json = response.data
            goToNetwork(json: json!, completionHandler: completionHandler)
//            do {
//                let data = try JSONDecoder().decode(Login.self, from: json!)
//
//                self.global.defaults.set(String(data.token!), forKey: "token")
//                print("NEW DATA")
//                print(data.token)
//            } catch {
//                print(error.localizedDescription)
//            }
        }
    }

    public static func getData<T: Decodable>(completionHandler: @escaping (T) -> Void) {
        let token = storage.defaults.string(forKey: "token")
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        request(baseUrl + gerRequestUrl, method: .get, encoding: JSONEncoding.default, headers: headers).responseData { response in
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
