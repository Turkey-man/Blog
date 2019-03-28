//
//  Network.swift
//  AlamofireTesting
//
//  Created by 1 on 3/17/19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Alamofire

public class Network {

    enum URLElemnts: String {
        case baseUrl = "https://storm.ualegion.com/api/v1/"
        case loginUrl = "security/auth/login"
        case gerRequestUrl = "projects/my"
    }
    
    public static func getToken<T: Decodable>(completionHandler: @escaping (T) -> Void) {
        let parameters = ["login" : "reader", "password" : "1234567a"]
        request(URLElemnts.baseUrl.rawValue + URLElemnts.loginUrl.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            guard let json = response.data else { return }
            goToNetwork(json: json, completionHandler: completionHandler)
        }
    }

    public static func getData<T: Decodable>(completionHandler: @escaping (T) -> Void) {
        let storage = Storage()
        guard let token = storage.defaults.string(forKey: "token") else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        request(URLElemnts.baseUrl.rawValue + URLElemnts.gerRequestUrl.rawValue, method: .get, encoding: JSONEncoding.default, headers: headers).responseData { response in
            let json = response.data
            
            switch response.response?.statusCode {
            case ResponseStatusCode.success.rawValue:
                goToNetwork(json: json!, completionHandler: completionHandler)
            default:
                print("response.response?.statusCode = \(String(describing: response.response?.statusCode))")
                break
            }
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
