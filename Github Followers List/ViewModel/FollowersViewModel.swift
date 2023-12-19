//
//  UsersViewModel.swift
//  Github Followers List
//
//  Created by Murad Yarmamedov on 18.12.23.
//

import Foundation

class FollowersViewModel: ObservableObject {
    
    @Published var followersList = [FollowersModel]()
    @Published var alertMessage: String?
    @Published var showAlert: Bool = false
    
    
    func getDataAsync(forUsername username:String) async {
        do {
            let followers = try await APICaller.getFollowersAsync(username: username)
            DispatchQueue.main.async {
                self.followersList = followers
            }
        }
        catch {
            print(error)
        }
    }
    
//    func getData(forUsername username: String) {
//        APICaller.getFollowers(username: username) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//                self?.alertMessage = "Invalid Username"
//                self?.showAlert = true
//            case .success(let followers):
//                if let followers = followers {
//                    DispatchQueue.main.async {
//                        self?.followersList = followers
//                    }
//                }
//            }
//        }
//    }
    
}

