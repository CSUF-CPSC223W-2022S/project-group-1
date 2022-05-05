//
//  MotivQuotes.swift
//  ataglance
//
//  Created by y41 on 3/8/22.
//

import Foundation
import UIKit

class MotivationalQuotesDB {
    var quotes: [String]
    var numOfQuotes: Int
    
    init() {
        // loads all quotes into quotes array
        quotes = []
        numOfQuotes = 0
    }
    
//    // hardcode quotes
//    init(description: String) {
//        quotes = ["Insanity: doing the same thing over and over again and expecting different results.",
//                 "Don't blame others. it won't make you a better person.",
//                 "I would rather be a little nobody, then to be an evil somebody.",
//                 "It is impossible for a man to learn what he thinks he already knows.",
//                 "Do what is right, not what is easy, nor what is popular.",
//                 "Reading should be a pleasure, not a chore."]
//        numOfQuotes = 5
//    }
}

class MotivationalQuotesMgr {
    var mqDB: MotivationalQuotesDB
    var currentQuoteInd: Int
    
    // hardcode quotes
    init() {
        mqDB = MotivationalQuotesDB()
        currentQuoteInd = 0
    }
    
//    func nextQuote() -> String {
//        let currentQuote = mqDB.quotes[currentQuoteInd % mqDB.numOfQuotes]
//        currentQuoteInd += 1
//        return currentQuote
//    }
    // api call
    func nextQuoteAPI(completion: @escaping ([AnyObject]?) -> Void) {
        let baseURL = URL(string: "https://zenquotes.io/api/random")!
        let task = URLSession.shared.dataTask(with: baseURL) {
            (data, response, error) in
            do {
                if let dataDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [AnyObject] {
                    completion(dataDict)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getQuoteImageURL(completion: @escaping (NSDictionary) -> Void) {
        var baseURL = URLComponents(string: "https://api.unsplash.com/photos/random")!
        baseURL.queryItems = [
            URLQueryItem(name: "client_id", value: "yfRPl3Ydtd6KJJ_3xK5AQ2bh3bVj2zDA13hVDm_Bryc")
        ]
        let request = URLRequest(url: baseURL.url!)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            do {
                if let dataDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    completion(dataDict)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    func getQuoteImage(imgURL: URL, completion: @escaping (UIImage?)->Void) {
        let task = URLSession.shared.dataTask(with: imgURL) {
            (data, response, error) in
            if let image = UIImage(data: data!) {
                completion(image)
            }
        }
        task.resume()
    }
}

