//
//  APITarget.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import Foundation
import Promises
import Moya

struct User {
    var userID: Int
    var name: String
    var nickname: String
    var email: String
}

enum APITarget {
    /// 회원가입
    case signUp(tokenID: String, name: String, nickname: String, email: String)
    /// 로그인
    case signIn(tokenID: String, email: String)
    /// 편지함
    case postbox(userID: String)
    /// 편지 쓰기
    case writeLetter(userID: Int, senderName: String, recieverName: String, title: String, content: String, preLetterID: String)
    /// 편지 삭제
    case deleteLetter(userID: String, letterIDs: [Int])
    /// 마이페이지
    case mypage(userID: String)
    /// 알람 설정
    case mypageSetting(subscribe: Bool)
    /// 닉네임 변경
    case updateMypage(userID: String, nickname: String)
}

extension APITarget: TargetType {

    var baseURL: URL { return URL(string: "https://api.myservice.com")! }
    var path: String {
        switch self {
        case .signUp:
            return "/users/sign-up"
        case .signIn:
            return "/users/sign-in"
        case .postbox:
            return "/postbox"
        case .writeLetter:
            return "/letter"
        case .deleteLetter:
            return "/letter"
        case .mypage:
            return "/mypage"
        case .mypageSetting:
            return "/mypage/setting"
        case .updateMypage:
            return "/mypage"
        }
    }
    var method: Moya.Method {
        switch self {
        case .signUp, .signIn:
            return .post
        case .postbox:
            return .get
        case .writeLetter:
            return .post
        case .deleteLetter:
            return .delete
        case .mypage:
            return .get
        case .mypageSetting:
            return .post
        case .updateMypage:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .signUp(tokenID: let tokenID, name: let name, nickname: let nickname, email: let email):
            return .requestParameters(parameters: ["tokenId": tokenID, "name": name, "nickname": nickname, "email": email],
                                      encoding: URLEncoding.default)
        case .signIn(tokenID: let tokenID, email: let email):
            return .requestParameters(parameters: ["tokenId": tokenID, "email": email],
                                      encoding: URLEncoding.default)
        case .postbox(userID: let userID):
            return .requestParameters(parameters: ["userId": userID],
                                      encoding: URLEncoding.default)
        case .writeLetter(userID: let userID,
                          senderName: let senderName,
                          recieverName: let recieverName,
                          title: let title,
                          content: let content,
                          preLetterID: let preLetterID):
            return .requestParameters(parameters: ["userId": userID,
                                                   "senderName": senderName,
                                                   "recieverName": recieverName,
                                                   "title": title,
                                                   "content": content,
                                                   "preLetterID": preLetterID],
                                      encoding: URLEncoding.default)
        case .deleteLetter(userID: let userID, letterIDs: let letterIDs):
            return .requestParameters(parameters: ["userId": userID,
                                                   "letterIDs": letterIDs],
                                      encoding: URLEncoding.default)
        case .mypage(userID: let userID):
            return .requestParameters(parameters: ["userId": userID], encoding: URLEncoding.default)
        case .mypageSetting(subscribe: let subscribe):
            return .requestParameters(parameters: ["subscribe": subscribe], encoding: URLEncoding.default)
        case .updateMypage(userID: let userID, nickname: let nickname):
            return .requestParameters(parameters: ["userID": userID,
                                                   "nickname": nickname], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .signUp(_, name: let name, nickname: let nickname, email: let email):
            return """
            {
                "userId": 1,
                "name": "\(name)",
                "nickname": "\(nickname)",
                "email": "\(email)"
            }
            """.utf8Encoded
        case .signIn:
            return """
            {
                "userId":1,
                "name":"구구구구",
                "nickname":"gugugugu",
                "email":"gugu@gmail.com"
            }
            """.utf8Encoded
        case .postbox:
            return """
            {
              "letters": [
                {
                  "sendingLetter":
                  {
                    "letterId": "",
                    "reciverId":"",
                    "senderId":"",
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  },
                  "receivingLetter":
                  {
                    "letterId": "",
                    "reciverId":"",
                    "senderId":"",
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  }
                }
              ]
            }
            """.utf8Encoded
        case .writeLetter:
            return """
            {
              "letters": [
                {
                  "sendingLetter": {
                    "letterId":1
                    "reciverId":2,
                    "senderId":1,
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  },
                  "receivingLetter": {
                    "letterId":1
                    "reciverId":1,
                    "senderId":2,
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  }
                }
              ]
            }
            """.utf8Encoded
        case .deleteLetter:
            return """
            {
              "letters": [
                {
                  "sendingLetter":
                  {
                    "letterId":2,
                    "reciverId":3,
                    "senderId":1,
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  },
                  "receivingLetter":
                  {
                    "letterId":3,
                    "reciverID":1,
                    "senderID":3,
                    "senderName":"",
                    "reciverName":"",
                    "title":"",
                    "content":"",
                    "createDate":""
                  }
                }
              ]
            }
            """.utf8Encoded
        case .mypage(userID: let userID):
            return """
            {
                    "userId": \(userID),
                    "name": "{{유저 이름}}",
                    "nickname": "{{유저 닉네임}}",
                    "email": "{{유저 이메일}}",
                    "subscribe": true
            }
            """.utf8Encoded
        case .mypageSetting(subscribe: let subscribe):
            return """
            {
              "subscribe": \(subscribe)
            }
            """.utf8Encoded
        case .updateMypage(_, nickname: let nickname):
            return """
            {
              "nickname": "\(nickname)"
            }
            """.utf8Encoded
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
