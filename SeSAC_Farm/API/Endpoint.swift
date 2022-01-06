//
//  Endpoint.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2021/12/30.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signup
    case login
    case changePassword
    case getPosts
    case getPostsByDesc
    case getPost(id: Int)
    case postPosts
    case putPosts(id: Int)
    case deletePosts(id: Int)
    case getComments
    case getCommentsByDesc
    case getCommentsByIndex(postId: Int)
    case postComments
    case putComments(id: Int)
    case deleteComments(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup:
            return .makeEndpoint("/auth/local/register")
        case .login:
            return .makeEndpoint("/auth/local")
        case .getPosts:
            return .makeEndpoint("/posts")
        case .getPostsByDesc:
            return .makeEndpoint("/posts?_sort=created_at:desc") // 임시방편
        case .postPosts:
            return .makeEndpoint("/posts")
        case .putPosts(let id):
            return .makeEndpoint("/posts/\(id)")
        case .deletePosts(let id):
            return .makeEndpoint("/posts/\(id)")
        case .getComments:
            return .makeEndpoint("/comments")
        case .getCommentsByDesc:
            return .makeEndpoint("/comments?_sort=created_at:desc")
        case .postComments:
            return .makeEndpoint("/comments")
        case .putComments(id: let id):
            return .makeEndpoint("/comments/\(id)")
        case .deleteComments(id: let id):
            return .makeEndpoint("/comments/\(id)")
        case .getCommentsByIndex(postId: let id):
            return .makeEndpoint("/comments?post=\(id)")
        case .getPost(id: let id):
            return .makeEndpoint("/posts?post=\(id)")
        case .changePassword:
            return .makeEndpoint("/custom/change-password")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static var login: URL {
        return makeEndpoint("/auth/local")
    }
}

extension URLSession {
    
    typealias handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult // 반환값 쓰고싶지 않을떄
    func dataTask(_ endpoint: URLRequest, handler: @escaping handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?, ErrorAPIReturns?) -> Void) {
        URLSession.shared.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("error : ", error!)
                    DispatchQueue.main.async {
                        completion(nil, .failed, nil)
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("response : ", response)
                } else {
                    completion(nil, .invalidResponse, nil)
                }
                
                print("data :", String(data: data!, encoding: .utf8)!)
                
                if let data = data, let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                    
                    print("completed decoding")
                    DispatchQueue.main.async {
                        completion(decodedData, nil, nil)
                    }
                } else {
                    let decodedData = try? JSONDecoder().decode(ErrorAPIReturns.self, from: data!)
                    DispatchQueue.main.async {
                        completion(nil, .invalidData, decodedData)
                    }
                }
            }
        }
    }
    
    static func requestArr<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping ([T]?, APIError?, ErrorAPIReturns?) -> Void) {
        URLSession.shared.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("error : ", error!)
                    DispatchQueue.main.async {
                        completion(nil, .failed, nil)
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("response : ", response)
                } else {
                    completion(nil, .invalidResponse, nil)
                }
                
                // print("data :", String(data: data!, encoding: .utf8)!)
                print(type(of: [T].self))
                
                if let data = data, let decodedData = try? JSONDecoder().decode([T].self, from: data) {
                    DispatchQueue.main.async {
                        print("decode Complete")
                        completion(decodedData, nil, nil)
                    }
                } else {
                    let decodedData = try? JSONDecoder().decode(ErrorAPIReturns.self, from: data!)
                    DispatchQueue.main.async {
                        completion(nil, .invalidData, decodedData)
                    }
                }
            }
        }
    }
}
