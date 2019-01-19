//
//  PlayerService.swift
//  OnlineRadio
//
//  Created by Артём Балашов on 19/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class PlayerService {
    static func fetchStreamURL(with stationID: Int) -> Promise<String> {
        return Promise(resolver: { (resolver) in
            let params: Parameters = [
                "station": stationID
            ]
            Alamofire.request(URL(string: "https://directory.shoutcast.com/Player/GetStreamUrl")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseString(completionHandler: { (response) in
                switch response.result {
                case .success(let data) :
                    resolver.fulfill(data)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        })
    }
}
