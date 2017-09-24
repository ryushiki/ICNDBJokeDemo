//
//  MainViewModel.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/2.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import Foundation

class MainModel:NSObject {
    
    func getJokeRandom() {
        let queryItems = ["firstName": "John", "lastName": "Doe"]
        
        let webClient = WebClient.init()
        webClient.request(path: Constant.JOKE_RANDOM_PATH, queryParams: queryItems) { (jokeResult: ResultType<Joke>) in
            switch jokeResult {
            case .success(let joke):
                CoredataUtil.sharedInstance.insertJoke(joke: joke)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
