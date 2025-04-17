//
//  NetworkManager.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 14/04/25.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

/// This extension is copyright of Hacking with swift website
extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}


@globalActor
actor NetworkActor {
    static let shared = NetworkActor()
}

@NetworkActor
class NetworkManager {
    static let shared = NetworkManager()
    private let queue = DispatchQueue(label: "NetworkManagerQueue") // serial queue
    private let client: Client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())

private init() {}
    
    /// Fetch posts from API path /posts
    /// - Returns: Array of post of error if the API call fails
    func fetchPosts() async -> ([Posts]?, Error?) {
        var posts: [Posts]?
        var postError: Error?
        
        do {
            let response = try await client.getPosts(Operations.getPosts.Input())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case .json(let postArray):
                    //let jsonData = try json.bodyDecode([Posts].self)
                    posts = []
                    for post in postArray {
                        let post = Posts(userId: post.userId, id: post.id, title: post.title, body: post.body)
                        posts?.append(post)
                    }
                }
            case .undocumented(statusCode: let statusCode, _):
                print("yes \(statusCode)")
            }
        } catch {
            postError = error
        }
        return (posts, postError)
    }
    
    /// Fetch comments from API path /comments
    /// - Returns: Array of comments of error if the API call fails
    func fetchComments() async -> ([Comments]?, Error?) {
        var comments: [Comments]?
        var commentError: Error?
        
        // comments
       do {
           let response = try await client.getComments(Operations.getComments.Input())
           switch response {
           case let .ok(okResponse):
               switch okResponse.body {
               case .json(let commentsArray):
                   //let jsonData = try json.bodyDecode([Posts].self)
                   comments = []
                   for comment in commentsArray {
                       let comment = Comments(postId: comment.postId, id: comment.id, name: comment.name, email: comment.email, body: comment.body)
                       comments?.append(comment)
                   }
               }
           case .undocumented(statusCode: let statusCode, _):
               print("yes \(statusCode)")
           }
       } catch {
           commentError = error
       }
        return (comments, commentError)
    }
    
    func fetchData() async -> ([Countries]?, Error?) {
        do {
            let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
            guard let url = URL(string: urlString) else {
                fatalError("Invalid URL: \(urlString)")
            }
            
            // Create a custom URLSession and decode a Double array from that
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = URLSession(configuration: config)
            
            return (try await session.decode([Countries].self, from: url), nil)
        } catch {
            //handle error
            print("error in reading countries ")
            print("Download error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
}
