//Copyright (c) 2017 pikachu987 <pikachu987@naver.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation
import UIKit

public extension Date{
    
    // MARK: initialize
    
    public init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    // MARK: property
    
    /// Date & Time Tuple Int
    public var dateTupleInt: (Int?, Int?, Int?, Int?, Int?, Int?){
        let calendar = Calendar.current
        return (yearInt(calendar), monthInt(calendar), dayInt(calendar), hourInt(calendar), minuteInt(calendar), secondInt(calendar))
    }
    
    /// Date & Time Tuple String
    public var getDateTuple: (String, String, String, String, String, String){
        let calendar = Calendar.current
        return (year(calendar), month(calendar), day(calendar), hour(calendar), minute(calendar), second(calendar))
    }
    
    
    
    /// Current time in milliseconds
    public var millisecondsSince1970: String {
        let date = (self.timeIntervalSince1970 * 1000.0).rounded()
        let value = "\(date)"
        if let milliseconds = value.split(separator: ".").first{ return "\(milliseconds)" }
        return "\(value)"
    }
    
    
    
    
    /// Search age
    public var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
    }
    
    
    
    
    
    
    
    // MARK: func
    
    
    
    /**
     Year Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func yearInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.year, from: self).year
    }
    
    /**
     Month Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func monthInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.month, from: self).month
    }
    
    /**
     Day Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func dayInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.day, from: self).day
    }
    
    /**
     Hour Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func hourInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.hour, from: self).hour
    }
    
    /**
     Minute Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func minuteInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.minute, from: self).minute
    }
    
    /**
     Second Int
     - parameter calendar: Calendar
     - returns: Int?
     */
    public func secondInt(_ calendar : Calendar = Calendar.current) -> Int?{
        return (calendar as NSCalendar).components(.second, from: self).second
    }
    
    /**
     Year String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func year(_ calendar : Calendar = Calendar.current, defaultValue: String = "1991") -> String{
        return yearInt(calendar)?.string ?? defaultValue
    }
    
    /**
     Month String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func month(_ calendar : Calendar = Calendar.current, defaultValue: String = "06") -> String{
        guard let value = monthInt(calendar) else { return defaultValue }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    /**
     Day String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func day(_ calendar : Calendar = Calendar.current, defaultValue: String = "21") -> String{
        guard let value = dayInt(calendar) else { return defaultValue }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    /**
     Hour String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func hour(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = hourInt(calendar) else { return defaultValue }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    /**
     Minute String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func minute(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = minuteInt(calendar) else { return defaultValue }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    /**
     Second String
     - parameter calendar: Calendar
     - parameter defaultValue: String
     - returns: Int?
     */
    public func second(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = secondInt(calendar) else { return defaultValue }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    
    
    /**
     Date YYYY MM DD
     - parameter calendar: Calendar
     - parameter of: String
     - returns: String
     */
    public func getDate(_ calendar : Calendar = Calendar.current, of: String = "-") -> String{
        return "\(year(calendar))\(of)\(month(calendar))\(of)\(day(calendar))"
    }
    
    /**
     Time HH mm ss
     - parameter dateOf: String
     - parameter of: String
     - returns: String
     */
    public func getTime(_ calendar : Calendar = Calendar.current, of: String = ":") -> String{
        return "\(hour(calendar))\(of)\(minute(calendar))\(of)\(second(calendar))"
    }
    
    
    /**
     Full Date YYYY MM DD HH mm ss
     - parameter dateOf: String
     - parameter timeOf: String
     - returns: String
     */
    public func getFullDate(_ dateOf: String = "-", timeOf: String = ":") -> String{
        let calendar = Calendar.current
        return "\(getDate(calendar, of: dateOf)) \(getTime(calendar, of: timeOf))"
    }
    
    
    
    
    
    /**
     Getting between dates
     - parameter toDate: Date
     - returns: Int
     */
    public func daysBetweenDate(_ toDate: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: toDate).day ?? 0
    }
    
    
    
    /**
     Show time only when dates are the same
     Show date only when date is different
     - parameter dateOf: String
     - parameter morning: String
     - parameter afternoon: String
     - returns: String
     */
    public func getDispalyRegDate(_ dateOf: String = ".", morning: String, afternoon: String) -> String{
        guard let hour = self.hourInt() else { return "" }
        if Date().dayInt() == self.dayInt() && Date().monthInt() == self.monthInt() && Date().yearInt() == self.yearInt(){
            if hour > 12{
                let hour = hour-12
                var hourStr = "0\(hour)"
                if hour > 9{ hourStr = "\(hour)" }
                return "\(afternoon) \(hourStr):\(self.minute())"
            }else{
                var hourStr = "0\(hour)"
                if hour > 9{ hourStr = "\(hour)" }
                return "\(morning) \(hourStr):\(self.minute())"
            }
        }else{ return self.getDate(of: dateOf) }
    }
    
    
    
    /**
     year Equal
     - parameter date: Date
     - returns: Bool
     */
    public func equalYear(_ date: Date) -> Bool{
        return self.year() == date.year() ? true : false
    }
    
    /**
     year & month Equal
     - parameter date: Date
     - returns: Bool
     */
    public func equalMonth(_ date: Date) -> Bool{
        return (self.equalYear(date) && self.month() == date.month()) ? true : false
    }
    
    /**
     year & month & day Equal
     - parameter date: Date
     - returns: Bool
     */
    public func equalDate(_ date: Date) -> Bool{
        return (self.equalMonth(date) && self.day() == date.day()) ? true : false
    }
    
    /**
     Make data in a format
     - parameter date: String?
     - parameter foramt: String
     - parameter timeZone: String
     - returns: Date?
     */
    public static func format(_ date: String?, foramt: String, timeZone: String = "GMT+0:00") -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = foramt
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormatter.date(from: date ?? "")
    }
    
    /**
     Make data in a format
     - parameter date: String?
     - parameter foramt: String
     - parameter timeZone: TimeZone
     - returns: Date?
     */
    public static func format(_ date: String?, foramt: String, timeZone: TimeZone) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = foramt
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: date ?? "")
    }
    
    /**
     Make data in a format
     - parameter date: String?
     - parameter foramt: String
     - parameter timeZone: String
     - parameter locale: Locale?
     - returns: Date?
     */
    public static func format(_ date: String?, foramt: String, timeZone: String = "GMT+0:00", locale: Locale?) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = foramt
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.locale = locale
        return dateFormatter.date(from: date ?? "")
    }
    
    /**
     Make data in a format
     - parameter date: String?
     - parameter foramt: String
     - parameter timeZone: TimeZone
     - parameter locale: Locale?
     - returns: Date?
     */
    public static func format(_ date: String?, foramt: String, timeZone: TimeZone, locale: Locale?) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = foramt
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.date(from: date ?? "")
    }
    
    
}
