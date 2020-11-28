//
//  CalendarViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import UIKit
import HorizonCalendar

class CalendarGridVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        let calendar = CalendarView(initialContent: makeCalendarContent())
        
        view.addSubview(calendar)
        calendar.anchor(top: view.topAnchor, leading: nil, bottom: view.bottomAnchor, trailing: nil, x: view.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 40, height: 0)
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Functions
    private func makeCalendarContent() -> CalendarViewContent {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: 0, to: Date())!
        let endDate = calendar.date(byAdding: .year, value: 1, to: Date())!
        
        return CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
//            .withDayItemModelProvider { (day) -> AnyCalendarItemModel in
//
//            }
    }
}
