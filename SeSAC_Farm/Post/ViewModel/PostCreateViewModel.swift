//
//  PostCreateViewModel.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation

class PostCreateViewModel {
    
    var singlePost: Observable<Post> = Observable(Post(id: 0, text: "", user: UserClass(id: 0, username: "", email: ""), createdAt: "", updatedAt: "", comments: []))
    
    func createPost(text: String, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.createPosts(text: text) { data, error, errorData in
            
            switch error {
            case .invalidData:
                completion(errorData)
            case .failed:
                completion(nil)
            case .invalidResponse:
                completion(nil)
            default:
                print("get data")
            }
            
            guard let data = data else {
                return
            }
            
            self.singlePost.value = data
            
            completion(nil)
        }
    }
    
    func updatePost(postId: Int, text: String, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.putPost(postId: postId, text: text) { data, error, errorData in
            
            switch error {
            case .invalidData:
                completion(errorData)
            case .failed:
                completion(nil)
            case .invalidResponse:
                completion(nil)
            default:
                print("get data")
            }
            
            guard let data = data else {
                return
            }
            
            self.singlePost.value = data
            
            completion(nil)
        }
    }
}
