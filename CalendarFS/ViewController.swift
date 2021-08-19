//
//  ViewController.swift
//  CalendarFS
//
//  Created by Sefer Furkan Sandal  on 17.08.2021.
//

import UIKit
import FSCalendar
import Foundation


class ViewController: UIViewController {
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendar: FSCalendar!
    fileprivate var gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var selectionType: CalendarSelectionType = .none {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.eventDefaultColor = .red
        calendar.appearance.eventSelectionColor = UIColor.red
        calendar.appearance.selectionColor = .red
        calendar.appearance.titleTodayColor = .gray
        calendar.appearance.titleDefaultColor = .gray
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.collectionView.register(TriwiCell.nib, forCellWithReuseIdentifier: TriwiCell.identifier)
        calendar.register(TriwiCellT.self, forCellReuseIdentifier: "cell")

//        calendar.today = nil
        calendar.firstWeekday = 2
        calendar.scope = .week
        calendar.locale = .current
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
        
        self.calendar.setCurrentPage(self.gregorian.date(byAdding: calendar.scope == .week ? .weekOfMonth : .month, value: -1, to: self.calendar.currentPage)!, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.calendar.setCurrentPage(self.gregorian.date(byAdding: calendar.scope == .week ? .weekOfMonth : .month, value: 1, to: self.calendar.currentPage)!, animated: true)
    }
    
    @IBAction func expandBtn(_ sender: Any) {
        
        let scope: FSCalendarScope = calendar.scope == .month ? .week : .month
        self.calendar.setScope(scope, animated: true)
    }
    
}

extension ViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected date:", date)
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("de-selected date:", date)
        self.configureVisibleCells()

    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.configureVisibleCells()
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: TriwiCell.identifier, for: date, at: position) as? TriwiCell
////        cell?.configure()
        let x: CalendarSelectionType = CalendarSelectionType.allCases.randomElement() ?? .none
        cell?.configure(selectionType: x)
//        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as? TriwiCellT
        cell?.selectionType = x
        return cell ?? FSCalendarCell()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let cx = cell as? TriwiCell
        cx?.configure(selectionType: cx?.selectionType ?? .none)
    }
    
    
}

extension ViewController {
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            let parsedCell = cell as? TriwiCell
            parsedCell?.configure(selectionType: parsedCell?.selectionType ?? .none)
//            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! TriwiCell)
        // Custom today circle
//        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {
            
            var selectionType = CalendarSelectionType.none
            
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
//                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
//                        selectionType = .middle
//                    }
//                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
//                        selectionType = .rightBorder
//                    }
//                    else if calendar.selectedDates.contains(nextDate) {
//                        selectionType = .leftBorder
//                    }
//                    else {
//                        selectionType = .single
//                    }
                }
            }
            else {
                selectionType = .none
            }
            diyCell.configure(selectionType: diyCell.selectionType)
            if selectionType == .none {
//                diyCell.selectionLayer.isHidden = true
                return
            }
            
//            diyCell.selectionLayer.isHidden = false
//            diyCell.selectionType = selectionType
            
        } else {
//            diyCell.circleImageView.isHidden = true
//            diyCell.selectionLayer.isHidden = true
        }
    }
}
