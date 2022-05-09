//
//  timerVC.swift
//  ataglance
//
//  Created by y41 on 3/15/22.
//

import UIKit
import UserNotifications

class timerVC: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet var timeDisplay: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var timerPicker: UIDatePicker!
    @IBOutlet var startButton: UIButton!
    var timer: CTimer = CTimer()
    var timer_: Timer = Timer()
    var hasStart: Bool = false
    var hasPause: Bool = false
    var center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // storyboard init
        resetButton.isEnabled = false
        timeDisplay.isHidden = true
        // ask for notification permission
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {}
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func pressStart(_ sender: Any) {
        if hasPause {
            hasPause = false
            timer_.invalidate()
            startButton.setTitle("Start", for: .normal)
            startButton.tintColor = UIColor.blue
        } else {
            hasPause = true
            timer_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            startButton.setTitle("Pause", for: .normal)
            startButton.tintColor = UIColor.red
            if !hasStart {
                hasStart = true
                timeDisplay.isHidden = false
                timer.setTime(seconds: Int(timerPicker.countDownDuration))
                setNotif(hr: timer.hour, min: timer.minute)
                timeDisplay.text = timer.displayTime()
                timerPicker.isHidden = true
                resetButton.isEnabled = true
            }
        }
    }
    
    @objc func updateTimer() {
        let canDec: Bool = timer.decrementSecond()
        if canDec {
            timeDisplay.text = timer.displayTime()
        } else {
            timer_.invalidate()
            pressReset(self)
        }
    }

    @IBAction func pressReset(_ sender: Any) {
        hasStart = false
        timeDisplay.isHidden = true
        timerPicker.isHidden = false
        timer_.invalidate()
        startButton.setTitle("Start", for: .normal)
        startButton.tintColor = UIColor.blue
        resetButton.isEnabled = false
    }
    
    func setNotif(hr: Int, min: Int) {
        center.getNotificationSettings {
            settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = "Timer"
                    content.body = "Times Up!!!"
                    content.sound = UNNotificationSound.default
                    let nowUTC = Date()
                    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
                    let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC)!.addingTimeInterval(TimeInterval(min * 60 + hr * 3600))
                    print(localDate)
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: localDate)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    self.center.add(request) { (error: Error?) in
                        if let error_ = error {
                            print(error_.localizedDescription)
                        }
                    }
                } else {
                    print("not authorized")
                }
            }
        }
    }
}
