//
//  MotivQuotes.swift
//  ataglance
//
//  Created by y41 on 3/8/22.
//

import Foundation

class MotivationalQuotesDB {
    var quotes: [String]
    var numOfQuotes: Int
    
    init() {
        // loads all quotes into quotes array
        quotes = []
        numOfQuotes = 0
    }
    
    // hardcode quotes
    init(description: String) {
        quotes = ["Insanity: doing the same thing over and over again and expecting different results.",
                 "Don't blame others. it won't make you a better person.",
                 "I would rather be a little nobody, then to be an evil somebody.",
                 "It is impossible for a man to learn what he thinks he already knows.",
                 "Do what is right, not what is easy, nor what is popular.",
                 "Reading should be a pleasure, not a chore."]
        numOfQuotes = 5
    }
}

class MotivationalQuotesMgr {
    var mqDB: MotivationalQuotesDB
    var currentQuoteInd: Int
    
    // hardcode quotes
    init() {
        mqDB = MotivationalQuotesDB(description: "hardcode")
        currentQuoteInd = 0
    }
    
    func nextQuote() -> String {
        let currentQuote = mqDB.quotes[currentQuoteInd % mqDB.numOfQuotes]
        currentQuoteInd += 1
        return currentQuote
    }
}
