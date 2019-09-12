//
//  DateExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Enums
public extension Date {


	public enum DayNameStyle {
		/// 3 letter day abbreviation of day name.
		case threeLetters

		/// 1 letter day abbreviation of day name.
		case oneLetter

		/// Full day name.
		case full
	}


	public enum MonthNameStyle {
		/// 3 letter month abbreviation of month name.
		case threeLetters

		/// 1 letter month abbreviation of month name.
		case oneLetter

		/// Full month name.
		case full
	}

}

// MARK: - Properties
public extension Date {

	/// SwifterSwift: User’s current calendar.
	public var calendar: Calendar {
		return Calendar.current
	}

	public var era: Int {
		return Calendar.current.component(.era, from: self)
	}

	public var quarter: Int {
		let month = Double(Calendar.current.component(.month, from: self))
		let numberOfMonths = Double(Calendar.current.monthSymbols.count)
		let numberOfMonthsInQuarter = numberOfMonths / 4
		return Int(ceil(month/numberOfMonthsInQuarter))
	}

	public var weekOfYear: Int {
		return Calendar.current.component(.weekOfYear, from: self)
	}

	public var weekOfMonth: Int {
		return Calendar.current.component(.weekOfMonth, from: self)
	}

	public var year: Int {
		get {
			return Calendar.current.component(.year, from: self)
		}
		set {
			guard newValue > 0 else { return }
			let currentYear = Calendar.current.component(.year, from: self)
			let yearsToAdd = newValue - currentYear
			if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
				self = date
			}
		}
	}

	public var month: Int {
		get {
			return Calendar.current.component(.month, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentMonth = Calendar.current.component(.month, from: self)
			let monthsToAdd = newValue - currentMonth
			if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
				self = date
			}
		}
	}

	public var day: Int {
		get {
			return Calendar.current.component(.day, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentDay = Calendar.current.component(.day, from: self)
			let daysToAdd = newValue - currentDay
			if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
				self = date
			}
		}
	}

	public var weekday: Int {
		return Calendar.current.component(.weekday, from: self)
	}

	public var hour: Int {
		get {
			return Calendar.current.component(.hour, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentHour = Calendar.current.component(.hour, from: self)
			let hoursToAdd = newValue - currentHour
			if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
				self = date
			}
		}
	}

	public var minute: Int {
		get {
			return Calendar.current.component(.minute, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentMinutes = Calendar.current.component(.minute, from: self)
			let minutesToAdd = newValue - currentMinutes
			if let date = Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self) {
				self = date
			}
		}
	}

	public var second: Int {
		get {
			return Calendar.current.component(.second, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentSeconds = Calendar.current.component(.second, from: self)
			let secondsToAdd = newValue - currentSeconds
			if let date = Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self) {
				self = date
			}
		}
	}

	public var nanosecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self)
		}
		set {
			let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
			guard allowedRange.contains(newValue) else { return }

			let currentNanoseconds = Calendar.current.component(.nanosecond, from: self)
			let nanosecondsToAdd = newValue - currentNanoseconds

			if let date = Calendar.current.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
				self = date
			}
		}
	}

	public var millisecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self) / 1000000
		}
		set {
			let nanoSeconds = newValue * 1000000
			let allowedRange = Calendar.current.range(of: .nanosecond, in: .second, for: self)!
			guard allowedRange.contains(nanoSeconds) else { return }

			if let date = Calendar.current.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
				self = date
			}
		}
	}

	public var isInFuture: Bool {
		return self > Date()
	}

	public var isInPast: Bool {
		return self < Date()
	}

	public var isInToday: Bool {
		return Calendar.current.isDateInToday(self)
	}

	public var isInYesterday: Bool {
		return Calendar.current.isDateInYesterday(self)
	}

	public var isInTomorrow: Bool {
		return Calendar.current.isDateInTomorrow(self)
	}

	/// SwifterSwift: Check if date is within a weekend period.
	public var isInWeekend: Bool {
		return Calendar.current.isDateInWeekend(self)
	}

	/// SwifterSwift: Check if date is within a weekday period.
	public var isWorkday: Bool {
		return !Calendar.current.isDateInWeekend(self)
	}

	/// SwifterSwift: Check if date is within the current week.
	public var isInCurrentWeek: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
	}

	/// SwifterSwift: Check if date is within the current month.
	public var isInCurrentMonth: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
	}

	/// SwifterSwift: Check if date is within the current year.
	public var isInCurrentYear: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
	}

	public var iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		return dateFormatter.string(from: self).appending("Z")
	}

	public var nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
		let min = components.minute!
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		components.nanosecond = 0
		return Calendar.current.date(from: components)!
	}

	public var nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
		let min = components.minute!
		components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		components.nanosecond = 0
		return Calendar.current.date(from: components)!
	}

	public var nearestQuarterHour: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
		let min = components.minute!
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		components.nanosecond = 0
		return Calendar.current.date(from: components)!
	}

	public var nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
		let min = components.minute!
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		components.nanosecond = 0
		return Calendar.current.date(from: components)!
	}

	public var nearestHour: Date {
		let min = Calendar.current.component(.minute, from: self)
		let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
		let date = Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))!

		if min < 30 {
			return date
		}
		return Calendar.current.date(byAdding: .hour, value: 1, to: date)!
	}

	public var timeZone: TimeZone {
		return Calendar.current.timeZone
	}

	public var unixTimestamp: Double {
		return timeIntervalSince1970
	}

}

// MARK: - Methods
public extension Date {

	public func adding(_ component: Calendar.Component, value: Int) -> Date {
		return Calendar.current.date(byAdding: component, value: value, to: self)!
	}

	public mutating func add(_ component: Calendar.Component, value: Int) {
		if let date = Calendar.current.date(byAdding: component, value: value, to: self) {
			self = date
		}
	}

}

#endif
