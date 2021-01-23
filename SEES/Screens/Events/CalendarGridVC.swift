//
//  CalendarViewController.swift
//  SEES
//
//  Created by Robert Parsons on 11/27/20.
//

import UIKit
import HorizonCalendar

class CalendarGridVC: UIViewController {
    private var eventsDictionary: [EventDay: [Event]] = [:]
    private var eventDaysSet: Set<EventDay> = []
    private let currentEventDay: EventDay
    private var cornerRadius: CGFloat = 0
    
    private var calendarGrid: CalendarView!
    
    // MARK: - Intializers
    init(events: [Event]) {
        let calendar = Calendar.current
        
        for event in events {
            let eventComponents = calendar.dateComponents([.month, .day], from: event.date)
            let eventDay = EventDay(day: eventComponents.day, month: eventComponents.month)
            self.eventDaysSet.insert(eventDay)
            
            if self.eventsDictionary[eventDay] != nil {
                self.eventsDictionary[eventDay]?.append(event)
            } else {
                self.eventsDictionary[eventDay] = []
                self.eventsDictionary[eventDay]?.append(event)
            }
        }
        
        let currentDayComponents = calendar.dateComponents([.month, .day], from: Date())
        self.currentEventDay = EventDay(day: currentDayComponents.day ?? 0, month: currentDayComponents.month ?? 0)

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
        configureCalendarGrid()
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        self.cornerRadius = (self.view.frame.width - 7 * 16) / 7 / 2
    }
    
    private func configureCalendarGrid() {
        calendarGrid.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            //TODO: handle multiple events in a single day in the future
            guard let event = self.eventsDictionary[EventDay(day: day.components.day, month: day.components.month)]?.first else { return }
            let eventDetailVC = EventDetailViewController(event: event)
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
    private func configureConstraints() {
        view.addSubview(calendarGrid)
        calendarGrid.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }

    // MARK: - Functions
    private func makeCalendarContent() -> CalendarViewContent {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: 0, to: Date())!
        let endDate = calendar.date(byAdding: .month, value: 6, to: Date())!
        
        return CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            .withDayItemModelProvider { [weak self] (day) -> AnyCalendarItemModel in
                guard let self = self else {
                    return CalendarItemModel<DayLabel>(invariantViewProperties: DayLabel.InvariantViewProperties(), viewModel: .init(day: day))
                }
                
                var invariantViewProperties = DayLabel.InvariantViewProperties(cornerRadius: self.cornerRadius)
                let horizonEventDay: EventDay = EventDay(day: day.components.day, month: day.components.month)
                
                if self.eventDaysSet.contains(horizonEventDay) {
                    invariantViewProperties.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
                    invariantViewProperties.backgroundColor = .systemTeal
                    invariantViewProperties.textColor = .white
                } else if self.currentEventDay == horizonEventDay {
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
        var font: UIFont = UIFont.systemFont(ofSize: 18)
        var textColor: UIColor = .label
        var backgroundColor: UIColor = .clear
        var cornerRadius: CGFloat = 14
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

struct EventDay: Hashable {
    let day: Int?
    let month: Int?
}
