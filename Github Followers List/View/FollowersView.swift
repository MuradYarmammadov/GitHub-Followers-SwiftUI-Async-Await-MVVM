//
//  ContentView.swift
//  Github Followers List
//
//  Created by Murad Yarmamedov on 18.12.23.
//

import SwiftUI

struct FollowersView: View {
    
    @ObservedObject var followersViewModel : FollowersViewModel
    @State var textFieldText: String = ""
    
    init() {
        self.followersViewModel = FollowersViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchSection
                followersList
            }
            .navigationTitle("Github Followers List")
        }
    }
    
    private var searchSection: some View {
        HStack {
            TextField("Write your GitHub Username", text: $textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
                .cornerRadius(10)
            searchButton
        }
        .background(Color.gray.opacity(0.1))
    }
    
    private var searchButton: some View {
        Button(action: {
            followersViewModel.search(forUsername: textFieldText)
        }) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.trailing, 8)
    }
    
    private var followersList: some View {
        List(followersViewModel.followersList, id: \.id) { follower in
            HStack {
                AsyncImage(url: URL(string: follower.avatarURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(25)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    case .failure:
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                            .cornerRadius(25)
                    @unknown default:
                        fatalError()
                    }
                }
                .padding(.trailing, 10)
                
                Text(follower.login)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView()
    }
}
