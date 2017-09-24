//
//  WebClient.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 2017/9/24.
//  Copyright © 2017年 liuzhihui. All rights reserved.
//

import Foundation

protocol JsonParser {
    static func parse(data: Data?) -> Self?
}

extension Joke: JsonParser {
    static func parse(data: Data?) -> Joke? {
        if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let JSON = json as? Dictionary<String, Any> {
                print("JSON: \(JSON)")

                if let value = JSON["value"] as? Dictionary<String, Any> {

                    var joke = Joke.init()
                    joke.jokeContent = value["joke"] as? String
                    if let _ = joke.jokeContent {
                        let mydateFormatter = DateFormatter()
                        mydateFormatter.dateFormat = "YYYY/MM/dd hh:mm:ss"
                        let dateString = mydateFormatter.string(from: Date.init())
                        joke.updateDate = dateString
                        return joke
                    }
                }
            }
        }

        return nil
    }
}

enum ResultType<T> {
    case success(T)
    case failure(Error)
}

enum NetworkError: Error {
    case server
    case invaild
}

struct WebClient {
    func request<T: JsonParser>(path: String, queryParams: [String : String], handler: @escaping (ResultType<T>) -> Void) {
        let queryItems = queryParams.map { URLQueryItem.init(name: $0.key, value: $0.value) }
        var urlCompponents = URLComponents.init()
        urlCompponents.scheme = "http"
        urlCompponents.host = Constant.JOKE_HOST
        urlCompponents.path = path
        urlCompponents.queryItems = queryItems
        
        guard let url = urlCompponents.url else {
            handler(.failure(NetworkError.server))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let joke = T.parse(data: data) {
                handler(.success(joke))
            } else {
                
            }
        }
        
        task.resume()
    }
}
