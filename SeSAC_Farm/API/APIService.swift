//
//  APIService.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?, ErrorAPIReturns?) -> Void) {
        
        print("login : ", identifier, password)
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = ("identifier=\(identifier)&password=\(password)").data(using: .utf8, allowLossyConversion: false)
        
        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?, ErrorAPIReturns?) -> Void) {
        print("register : ", username, email, password)
        
        var request = URLRequest(url: Endpoint.signup.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = ("username=\(username)&email=\(email)&password=\(password)").data(using: .utf8, allowLossyConversion: false)
        
        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (User?, APIError?, ErrorAPIReturns?) -> Void) {
        print("changePassword : ", currentPassword, newPassword, confirmNewPassword)
        
        var request = URLRequest(url: Endpoint.changePassword.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = ("currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)").data(using: .utf8, allowLossyConversion: false)
        
        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
}

extension APIService {
    static func getPosts(completion: @escaping ([Post]?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get posts")
        
        var request = URLRequest(url: Endpoint.getPosts.url)
        request.httpMethod = Method.GET.rawValue
        
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            URLSession.requestArr(endpoint: request, completion: completion)
        }
    }
    
    static func getPostsByDecending(completion: @escaping ([Post]?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get posts")
        
        var request = URLRequest(url: Endpoint.getPostsByDesc.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            URLSession.requestArr(endpoint: request, completion: completion)
        }
    }
    
    static func getPostsById(postId: Int, completion: @escaping (Post?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get posts")
        
        var request = URLRequest(url: Endpoint.getPostsByDesc.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func createPosts(text: String, completion: @escaping (Post?, APIError?, ErrorAPIReturns?) -> Void) {
        print("create posts text : ", text)
        
        var request = URLRequest(url: Endpoint.postPosts.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = ("text=\(text)").data(using: .utf8, allowLossyConversion: false)

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func putPost(postId: Int, text: String, completion: @escaping (Post?, APIError?, ErrorAPIReturns?) -> Void) {
        print("put post text, id : ", text, postId)
        
        var request = URLRequest(url: Endpoint.putPosts(id: postId).url)
        request.httpMethod = Method.PUT.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = ("text=\(text)").data(using: .utf8, allowLossyConversion: false)

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func deletePost(postId: Int, completion: @escaping (Post?, APIError?, ErrorAPIReturns?) -> Void) {
        print("delete post id : ", postId)
        
        var request = URLRequest(url: Endpoint.deletePosts(id: postId).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
}

extension APIService {
    static func getComments(completion: @escaping ([Comments]?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get Comments")
        
        var request = URLRequest(url: Endpoint.getComments.url)
        request.httpMethod = Method.GET.rawValue
        
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            URLSession.requestArr(endpoint: request, completion: completion)
        }
    }
    
    static func getCommentsByPostId(postId: Int, completion: @escaping ([Comments]?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get Comments")
        
        var request = URLRequest(url: Endpoint.getCommentsByIndex(postId: postId).url)
        request.httpMethod = Method.GET.rawValue
        
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            URLSession.requestArr(endpoint: request, completion: completion)
        }
    }
    
    static func getCommentsByDecending(completion: @escaping ([Comments]?, APIError?, ErrorAPIReturns?) -> Void) {
        print("get Comments dec")
        
        var request = URLRequest(url: Endpoint.getCommentsByDesc.url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.main.async {
            URLSession.requestArr(endpoint: request, completion: completion)
        }
    }
    
    static func createComments(postId: Int, text: String, completion: @escaping (Comments?, APIError?, ErrorAPIReturns?) -> Void) {
        print("create Comments text : ", text, postId)
        
        var request = URLRequest(url: Endpoint.postComments.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = ("comment=\(text)&post=\(postId)").data(using: .utf8, allowLossyConversion: false)

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func putComments(commentsId: Int, postId: Int, text: String, completion: @escaping (Comments?, APIError?, ErrorAPIReturns?) -> Void) {
        print("put Comments text, id : ", text, postId, commentsId)
        
        var request = URLRequest(url: Endpoint.putComments(id: commentsId).url)
        request.httpMethod = Method.PUT.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = ("comment=\(text)&post=\(postId)").data(using: .utf8, allowLossyConversion: false)

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
    
    static func deleteComments(commentsId: Int, completion: @escaping (Comments?, APIError?, ErrorAPIReturns?) -> Void) {
        print("delete Comments id : ", commentsId)
        
        var request = URLRequest(url: Endpoint.deleteComments(id: commentsId).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(UserDefaults.token)", forHTTPHeaderField: "Authorization")

        DispatchQueue.main.async {
            URLSession.request(endpoint: request, completion: completion)
        }
    }
}
