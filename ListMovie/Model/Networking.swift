//
//  Networking.swift
//  ListMovie
//
//  Created by Benjamin Kolosov on 12/12/2018.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation
import Alamofire

typealias movieJSON = [String: Any]

struct Networking{
    
    let url : String!
    let apiKey = "4fcfff01a486cfb143aa1c110de59f83"
    var titleMovie   : String!
    var description  : String!
    
    
    init(url: String) {
        let accountUrl = "?sort_by=popularity.desc&api_key=\(apiKey)"
        self.url = url + accountUrl
    }
    
    func getToken(completion: @escaping (movieJSON?) -> Void){
        
        let reachabilityManager = NetworkReachabilityManager()
        
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = reachabilityManager?.isReachable, isNetworkReachable == true {

                
                var request = URLRequest(url: URL(string: self.url!)!)
                request.httpMethod = "GET"
                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
                
                Alamofire.request(request).validate().responseJSON(completionHandler: { (response) in

                    guard let json = response.result.value else {
                        return
                    }

                    let jsonDict = json as! [String: Any]

                    completion(jsonDict)
                })
                
            }else{
                print("Not Connected")
                
            }
        }
        
       
        
        
    }
    
}
