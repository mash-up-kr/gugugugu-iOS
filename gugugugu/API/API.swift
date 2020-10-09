//
//  API.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import Foundation
import Promises
import Moya

/**

 Call Site Usages Example
    - API().request(.updateMypage(userID: "1234", nickname: "유저네임")).map(to: Decodable.Protocol).then { ... }
 */

typealias API = MoyaProvider<APITarget>

extension MoyaProvider {
    func request(_ target: Target,
                 callbackQueue: DispatchQueue? = nil,
                 progress: ProgressBlock? = nil) -> Promise<Moya.Response> {
        Promise { [weak self] fulfill, reject in
            self?.request(target, callbackQueue: callbackQueue, progress: progress) { result in
                switch result {
                case let .success(response):
                    fulfill(response)
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
}

extension Promise where Value: Moya.Response {
    func map<T: Decodable>(to: T.Type) -> Promise<T> {
        return self.then({ response in
            return try JSONDecoder().decode(T.self, from: response.data)
        })
    }
}
