//
//  NSDate.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation


public extension Date{
    public func yearInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.year, from: self)
        let year = components.year
        return year
    }
    public func monthInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.month, from: self)
        let month = components.month
        return month
    }
    public func dayInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.day, from: self)
        let day = components.day
        return day
    }
    public func hourInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        return hour
    }
    public func minuteInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        return minute
    }
    public func secondInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.second, from: self)
        let second = components.second
        return second
    }
    public func year(_ calendar : Calendar = Calendar.current, defaultValue: String = "1991") -> String{
        guard let value = yearInt(calendar) else {
            return defaultValue
        }
        return "\(value)"
    }
    public func addDoubleDate(_ value: Int) -> String{
        if value < 10{
            return "0\(value)"
        }else{
            return "\(value)"
        }
    }
    public func month(_ calendar : Calendar = Calendar.current, defaultValue: String = "06") -> String{
        guard let value = monthInt(calendar) else {
            return defaultValue
        }
        return self.addDoubleDate(value)
    }
    public func day(_ calendar : Calendar = Calendar.current, defaultValue: String = "21") -> String{
        guard let value = dayInt(calendar) else {
            return defaultValue
        }
        return self.addDoubleDate(value)
    }
    public func hour(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = hourInt(calendar) else {
            return defaultValue
        }
        return self.addDoubleDate(value)
    }
    public func minute(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = minuteInt(calendar) else {
            return defaultValue
        }
        return self.addDoubleDate(value)
    }
    public func second(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = secondInt(calendar) else {
            return defaultValue
        }
        return self.addDoubleDate(value)
    }
    public func getDate(_ calendar : Calendar = Calendar.current, of: String = "-") -> String{
        return "\(year(calendar))\(of)\(month(calendar))\(of)\(day(calendar))"
    }
    public func getTime(_ calendar : Calendar = Calendar.current, of: String = ":") -> String{
        return "\(hour(calendar))\(of)\(minute(calendar))\(of)\(second(calendar))"
    }
    public func getFullDate() -> String{
        let calendar = Calendar.current
        return "\(getDate(calendar)) \(getTime(calendar))"
    }
    public func getDateTupleInt() -> (Int?, Int?, Int?, Int?, Int?, Int?){
        let calendar = Calendar.current
        return (yearInt(calendar), monthInt(calendar), dayInt(calendar), hourInt(calendar), minuteInt(calendar), secondInt(calendar))
    }
    public func getDateTuple() -> (String, String, String, String, String, String){
        let calendar = Calendar.current
        return (year(calendar), month(calendar), day(calendar), hour(calendar), minute(calendar), second(calendar))
    }
    
    public func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    public func getDispalyRegDate(_ dateOf: String = ".") -> String{
        guard let hour = self.hourInt() else {
            return ""
        }
        if Date().dayInt() == self.dayInt(){
            if hour > 12{
                let hour = hour-12
                var hourStr = "0\(hour)"
                if hour > 9{
                    hourStr = "\(hour)"
                }
                return "오후 \(hourStr):\(self.minute())"
            }else{
                var hourStr = "0\(hour)"
                if hour > 9{
                    hourStr = "\(hour)"
                }
                return "오전 \(hourStr):\(self.minute())"
            }
        }else{
            return self.getDate(of: dateOf)
        }
    }
}
