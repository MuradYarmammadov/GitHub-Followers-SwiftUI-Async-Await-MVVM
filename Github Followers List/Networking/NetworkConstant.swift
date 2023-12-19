//
//  NetworkConstant.swift
//  Github Followers List
//
//  Created by Murad Yarmamedov on 18.12.23.
//

import Foundation

class NetworkConstant {
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init(){
        
    }
    
    public func apiUrl(forUsername username: String) -> String {
           return "https://api.github.com/users/\(username)/followers"
       }
}
