//
//  APICaller.swift
//  Github Followers List
//
//  Created by Murad Yarmamedov on 18.12.23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case parseError
}

public class APICaller {
    
//    static func getFollowersAsync(username: String) async throws -> [FollowersModel] {
//
//        let urlString = NetworkConstant.shared.apiUrl(forUsername: username)
//
//        guard let url = URL(string: urlString) else {
//            throw NetworkError.urlError
//        }
//
//        let (data, _) = try await URLSession.shared.data(from: url)
//
//        let resultData = try? JSONDecoder().decode([FollowersModel].self, from: data)
//
//        return resultData ?? []
//    }
    
    static func getFollowersContinuation(username: String) async throws -> [FollowersModel] {
        
        try await withCheckedThrowingContinuation({ continuation in
            getFollowers(username: username) { result in
                switch result {
                case.success(let follower):
                    continuation.resume(returning: follower ?? [])
                case.failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    
    static func getFollowers(username: String, completion: @escaping (Result<[FollowersModel]?,NetworkError>) -> Void) {
        
        let urlString = NetworkConstant.shared.apiUrl(forUsername: username)
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil,
               let data = data,
               let resultData = try? JSONDecoder().decode([FollowersModel].self, from: data) {
                completion(.success(resultData))
            } else {
                completion(.failure(.parseError))
            }
        }.resume()
    }
}
