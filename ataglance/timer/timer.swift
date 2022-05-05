//
//  timer.swift
//  ataglance
//
//  Created by y41 on 3/15/22.
//

import Foundation

class CTimer {
    var hour: Int
    var minute: Int
    var second: Int
    
    init() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
    
    func setTime(seconds: Int) {
        let minutes = seconds / 60
        self.minute = minutes % 60
        self.hour = minutes / 60
        self.second = 0
    }
    
    func displayTime() -> String {
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        } else {
            return String(format: "%02d:%02d", minute, second)
        }
    }
    
    func decrementSecond() -> Bool {
        if hour == 0 && minute == 0 && second == 0 {
            return false
        }
        
        if second > 0 {
            second -= 1
        } else {
            if minute > 0 {
                minute -= 1
                second = 59
            } else {
                hour -= 1
                minute = 59
                second = 59
            }
        }
        return true
    }
}
