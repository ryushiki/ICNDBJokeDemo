//
//  MainViewModel.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/2.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import Foundation
import Alamofire

class MainModel:NSObject {
    
    func getJokeRandom() {
        Alamofire.request(Constant.JOKE_RANDOM_URL).responseJSON { (response) in
            if let JSON = response.result.value as? Dictionary<String, Any> {
                print("JSON: \(JSON)")
                
                if let value = JSON["value"] as? Dictionary<String, Any> {
                    
                    let joke = Joke.init()
                    joke.jokeContent = value["joke"] as? String
                    if let _ = joke.jokeContent {
                        let mydateFormatter = DateFormatter()
                        mydateFormatter.dateFormat = "YYYY/MM/dd hh:mm:ss"
                        let dateString = mydateFormatter.string(from: Date.init())
                        joke.updateDate = dateString
                        CoredataUtil.sharedInstance.insertJoke(joke: joke)
                    }
                }
            }
        }
    }
}
