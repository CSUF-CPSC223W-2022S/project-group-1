//
//  timerTest.swift
//  ataglanceTests
//
//  Created by y41 on 4/7/22.
//

import XCTest
@testable import ataglance

class timerTest: XCTestCase {

    func testInitTimer1() {
        let t = CTimer()
        t.setTime(seconds: 0)
        XCTAssertEqual(t.minute, 0)
        XCTAssertEqual(t.hour, 0)
    }
    
    func testInitTimer2() {
        let t = CTimer()
        t.setTime(seconds: 3600)
        XCTAssertEqual(t.minute, 0)
        XCTAssertEqual(t.hour, 1)
    }
    
    func testInitTimer3() {
        let t = CTimer()
        t.setTime(seconds: 3660)
        XCTAssertEqual(t.minute, 1)
        XCTAssertEqual(t.hour, 1)
    }
    
    func testTimerDisplay1() {
        let t = CTimer()
        t.setTime(seconds: 18900)
        XCTAssertEqual(t.displayTime(), "05:15:00")
    }
    
    func testTimerDisplay2() {
        let t = CTimer()
        t.setTime(seconds: 900)
        XCTAssertEqual(t.displayTime(), "15:00")
    }
    
    func testTimerDec1() {
        let t = CTimer()
        t.setTime(seconds: 900)
        t.decrementSecond()
        XCTAssertEqual(t.displayTime(), "14:59")
    }
    
    func testTimerDec2() {
        let t = CTimer()
        t.setTime(seconds: 900)
        t.decrementSecond()
        t.decrementSecond()
        XCTAssertEqual(t.displayTime(), "14:58")
    }
    
    func testTimerDec3() {
        let t = CTimer()
        t.setTime(seconds: 18000)
        t.decrementSecond()
        XCTAssertEqual(t.displayTime(), "04:59:59")
    }

}
