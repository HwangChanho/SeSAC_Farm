//
//  CommentsViewModel.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation

class CommentsViewModel {
    var comments = Observable<[Comments]>([])
    
    var singleComment: Observable<Comments> = Observable(Comments(id: 0, comment: "", user: UserClass(id: 0, username: "", email: ""), post: Posts(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    func getComments(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.getComments { data, error, errorData in
            
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
            
            self.comments.value.removeAll()
            
            for item in data {
                self.comments.value.append(item)
            }
            
            completion(nil)
        }
    }
    
    func getCommentById(postId: Int, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.getCommentsByPostId(postId: postId) { data, error, errorData in
            
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
            
            self.comments.value.removeAll()
            
            for item in data {
                self.comments.value.append(item)
            }
            
            completion(nil)
        }
        
    }
    
    func getCommentsInDecendingOrder(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.getCommentsByDecending { data, error, errorData in
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
            
            self.comments.value.removeAll()
            
            for item in data {
                self.comments.value.append(item)
            }
            
            completion(nil)
        }
    }
    
    func deleteComment(commentId: Int, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.deleteComments(commentsId: commentId) { data, error, errorData in
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
            
            self.singleComment.value = data
            
            completion(nil)
        }
    }

    func createComment(postId: Int, text: String, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.createComments(postId: postId, text: text) { data, error, errorData in
            
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
            
            self.singleComment.value = data
            
            completion(nil)
        }
    }
    
    func updateComment(commentsId: Int, postId: Int, text: String, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.putComments(commentsId: commentsId, postId: postId, text: text) { data, error, errorData in
            
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
            
            self.singleComment.value = data
            
            completion(nil)
        }
    }
}

extension CommentsViewModel {
    var numberOfRowInSection: Int {
        return comments.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Comments {
        return comments.value[indexPath.row]
    }
}
