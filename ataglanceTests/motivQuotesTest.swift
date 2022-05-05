//
//  motivQuotesTest.swift
//  ataglanceTests
//
//  Created by y41 on 3/9/22.
//

import XCTest
@testable import ataglance

class motivQuotesTest: XCTestCase {

    func testInitMQDB1() {
        let db = MotivationalQuotesDB(description: "hardcode")
        XCTAssertEqual(db.numOfQuotes, 5)
    }
    
    func testInitMQDB2() {
        let db = MotivationalQuotesDB(description: "hardcode")
        XCTAssertEqual(db.quotes[1], "Don't blame others. it won't make you a better person.")
    }
    
    func testNextQuote1() {
        let mgr = MotivationalQuotesMgr()
        XCTAssertEqual(mgr.currentQuoteInd, 0)
        XCTAssertEqual(mgr.nextQuote(), "Insanity: doing the same thing over and over again and expecting different results.")
    }
    
    func testNextQuote2() {
        let mgr = MotivationalQuotesMgr()
        mgr.nextQuote()
        XCTAssertEqual(mgr.nextQuote(), "Don't blame others. it won't make you a better person.")
    }
}
