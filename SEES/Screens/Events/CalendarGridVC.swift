//
//  CalendarViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import UIKit
import HorizonCalendar

class CalendarGridVC: UIViewController {
    private var events: [Event] = []
    private let currentDay: DateComponents
    private var cornerRadius: CGFloat {
        return (self.view.frame.width - 7 * 8) / 7 / 2
    }
    
    private var calendarGrid: CalendarView!
    
    // MARK: - Intializers
    init(events: [Event]) {
        self.events = events
        let date = Date()
        let calendar = Calendar.current
        self.currentDay = calendar.dateComponents([.year, .month, .day], from: date)
        
        super.init(nibName: nil, bundle: nil)
        
        self.calendarGrid = CalendarView(initialContent: makeCalendarContent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureConstraints() {
        view.addSubview(calendarGrid)
        calendarGrid.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    // MARK: - Functions
    private func makeCalendarContent() -> CalendarViewContent {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: 0, to: Date())!
        let endDate = calendar.date(byAdding: .month, value: 6, to: Date())!
        
        return CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            .withDayItemModelProvider { (day) -> AnyCalendarItemModel in
                var invariantViewProperties = DayLabel.InvariantViewProperties(font: UIFont.systemFont(ofSize: 18), textColor: .label, backgroundColor: .clear, cornerRadius: self.cornerRadius)
                
                if self.currentDay.day == day.day && self.currentDay.month == day.components.month && self.currentDay.year == day.components.year {
                    invariantViewProperties.font = UIFont.boldSystemFont(ofSize: 18)
                    invariantViewProperties.backgroundColor = .tertiarySystemFill
                }
                
                return CalendarItemModel<DayLabel>(invariantViewProperties: invariantViewProperties, viewModel: .init(day: day))
            }
            .withInterMonthSpacing(24)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
    }
}

struct DayLabel: CalendarItemViewRepresentable {
    struct InvariantViewProperties: Hashable {
        var font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
        var cornerRadius: CGFloat
    }
    
    struct ViewModel: Equatable {
        let day: Day
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = invariantViewProperties.cornerRadius
        
        return label
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.day.day)"
    }
}
