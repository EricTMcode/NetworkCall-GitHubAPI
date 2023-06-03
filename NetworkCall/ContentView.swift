//
//  ContentView.swift
//  NetworkCall
//
//  Created by Eric on 03/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)
            
            Text("Username")
                .bold()
                .font(.title3)
            
            Text("This is where the GitHub bio will go. Let's make it long so  it spans two lines.")
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/sallen0400"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        } catch {
            <#CatchBlock#>
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
}
