//
//  DateExtension2.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 29/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension Date {
    /*
    public func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)
            
        case .second:
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self)
            
        case .minute:
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self)
            
        case .hour:
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self)
            
        case .day:
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = value - currentDay
            return Calendar.current.date(byAdding: .day, value: daysToAdd, to: self)
            
        case .month:
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self)
            
        case .year:
            guard value > 0 else { return nil }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self)
            
        default:
            return Calendar.current.date(bySetting: component, value: value, of: self)
        }
    }
    */
    
    public func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return Calendar.current.startOfDay(for: self)
        }
        
        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]
                
            case .hour:
                return [.year, .month, .day, .hour]
                
            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]
                
            case .month:
                return [.year, .month]
                
            case .year:
                return [.year]
                
            default:
                return []
            }
        }
        
        guard !components.isEmpty else { return nil }
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    /*
    public func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = adding(.minute, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .hour:
            var date = adding(.hour, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .day:
            var date = adding(.day, value: 1)
            date = Calendar.current.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = Calendar.current.date(from:
                Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date
            
        case .month:
            var date = adding(.month, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .year:
            var date = adding(.year, value: 1)
            let after = Calendar.current.date(from:
                Calendar.current.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
    */
    
    public func isInCurrent(_ component: Calendar.Component) -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: component)
    }
    
    public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    public func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    public func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: get number of seconds between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of seconds between self and given date.
    public func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }
    
    /// SwifterSwift: get number of minutes between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of minutes between self and given date.
    public func minutesSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/60
    }
    
    /// SwifterSwift: get number of hours between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of hours between self and given date.
    public func hoursSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/3600
    }
    
    /// SwifterSwift: get number of days between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of days between self and given date.
    public func daysSince(_ date: Date) -> Double {
        return timeIntervalSince(date)/(3600*24)
    }
    
    /// SwifterSwift: check if a date is between two other dates
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false)
    /// - Returns: true if the date is between the two given dates.
    public func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
    /// SwifterSwift: check if a date is a number of date components of another date
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date
    public func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = Calendar.current.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }
    
    /// SwifterSwift: Random date between two dates.
    ///
    ///     Date.random()
    ///     Date.random(from: Date())
    ///     Date.random(upTo: Date())
    ///     Date.random(from: Date(), upTo: Date())
    ///
    /// - Parameters:
    ///   - fromDate: minimum date (default is Date.distantPast)
    ///   - toDate: maximum date (default is Date.distantFuture)
    /// - Returns: random date between two dates.
    public static func random(from fromDate: Date = Date.distantPast, upTo toDate: Date = Date.distantFuture) -> Date {
        guard fromDate != toDate else {
            return fromDate
        }
        
        let diff = llabs(Int64(toDate.timeIntervalSinceReferenceDate - fromDate.timeIntervalSinceReferenceDate))
        var randomValue: Int64 = 0
        arc4random_buf(&randomValue, MemoryLayout<Int64>.size)
        randomValue = llabs(randomValue%diff)
        
        let startReferenceDate = toDate > fromDate ? fromDate : toDate
        return startReferenceDate.addingTimeInterval(TimeInterval(randomValue))
    }
    
}

// MARK: - Initializers
public extension Date {
    
    /// SwifterSwift: Create a new date form calendar components.
    ///
    ///     let date = Date(year: 2010, month: 1, day: 12) // "Jan 12, 2010, 7:45 PM"
    ///
    /// - Parameters:
    ///   - calendar: Calendar (default is current).
    ///   - timeZone: TimeZone (default is current).
    ///   - era: Era (default is current era).
    ///   - year: Year (default is current year).
    ///   - month: Month (default is current month).
    ///   - day: Day (default is today).
    ///   - hour: Hour (default is current hour).
    ///   - minute: Minute (default is current minute).
    ///   - second: Second (default is current second).
    ///   - nanosecond: Nanosecond (default is current nanosecond).
    public init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = TimeZone.current,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        
        if let date = calendar?.date(from: components) {
            self = date
        } else {
            return nil
        }
    }
    
    /// SwifterSwift: Create date object from ISO8601 string.
    ///
    ///     let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    public init?(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: iso8601String) {
            self = date
        } else {
            return nil
        }
    }
    
    /// SwifterSwift: Create new date object from UNIX timestamp.
    ///
    ///     let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    public init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
    
    /// SwifterSwift: Create date object from Int literal
    ///
    ///     let date = Date(integerLiteral: 2017_12_25) // "2017-12-25 00:00:00 +0000"
    /// - Parameter value: Int value, e.g. 20171225, or 2017_12_25 etc.
    public init?(integerLiteral value: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(value)) else { return nil }
        self = date
    }
    
}
