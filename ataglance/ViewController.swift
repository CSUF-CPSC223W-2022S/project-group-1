//
//  ViewController.swift
//  ataglance
//
//  Created by Abraham Medina on 2/23/22.
//

import UIKit

// Makes CalendarCollectionView link with this file
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
// Call cells view and month view when calendar loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
// Sets days in cells. Divides size of each week - the spacing between each cell, and divides by days in week (never more than 8)
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
// Selected Date was initialized to today's date. e.g. Calendar foundation
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
// 42 = # of cells. 31 days in month. If 1st day lands on saturday, thats at least 6 rows to fill in 7 days. 6 * 7 = 42
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("") // account for empty squares
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
// Formatted month/year/date/day view
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }

// Uses reuse identifier to link Strings
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for:
            indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    @IBAction func previousMonth(_ sender: Any) {
// Pressing back will take you back a month
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
// Pressing forward will take you to the next month
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
// Disables rotation of screen
    override open var shouldAutorotate: Bool {
        return false
    }
    
}
