//
//  PostViewModel.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import Foundation

class PostViewModel: UserDefaults {
    
    var posts = Observable<[Post]>([])
    
    var singlePost: Observable<Post> = Observable(Post(id: 0, text: "", user: UserClass(id: 0, username: "", email: ""), createdAt: "", updatedAt: "", comments: []))
    
    func getPosts(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.getPosts { data, error, errorData in
            
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
            
            self.posts.value.removeAll()
            
            for item in data {
                self.posts.value.append(item)
            }
            
            completion(nil)
        }
    }
    
    func getPostsInDecendingOrder(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.getPostsByDecending { data, error, errorData in
            
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
            
            self.posts.value.removeAll()
            
            for item in data {
                self.posts.value.append(item)
            }
            
            completion(nil)
        }
    }
    
    func deletePost(postId: Int, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.deletePost(postId: postId) { data, error, errorData in
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

extension PostViewModel {
    var numberOfRowInSection: Int {
        return posts.value.count
    }
    
    func getNumberOfMemos(row: Int) -> Int {
        return posts.value[row].comments.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Post {
        return posts.value[indexPath.row]
    }
}
