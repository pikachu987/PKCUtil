//
//  NSDate.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation


extension Date{
    func yearInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.year, from: self)
        let year = components.year
        return year!
    }
    func monthInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.month, from: self)
        let month = components.month
        return month!
    }
    func dayInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.day, from: self)
        let day = components.day
        return day!
    }
    func hourInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        return hour!
    }
    func minuteInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        return minute!
    }
    func secondInt(_ calendar : Calendar = Calendar.current) -> Int{
        let components = (calendar as NSCalendar).components(.second, from: self)
        let second = components.second
        return second!
    }
    func year(_ calendar : Calendar = Calendar.current) -> String{
        return "\(yearInt(calendar))"
    }
    func month(_ calendar : Calendar = Calendar.current) -> String{
        let month = monthInt(calendar)
        if month < 10{
            return "0\(month)"
        }else{
            return "\(month)"
        }
    }
    func day(_ calendar : Calendar = Calendar.current) -> String{
        let day = dayInt(calendar)
        if day < 10{
            return "0\(day)"
        }else{
            return "\(day)"
        }
    }
    func hour(_ calendar : Calendar = Calendar.current) -> String{
        let hour = hourInt(calendar)
        if hour < 10{
            return "0\(hour)"
        }else{
            return "\(hour)"
        }
    }
    func minute(_ calendar : Calendar = Calendar.current) -> String{
        let minute = minuteInt(calendar)
        if minute < 10{
            return "0\(minute)"
        }else{
            return "\(minute)"
        }
    }
    func second(_ calendar : Calendar = Calendar.current) -> String{
        let second = secondInt(calendar)
        if second < 10{
            return "0\(second)"
        }else{
            return "\(second)"
        }
    }
    func getDate() -> String{
        let calendar = Calendar.current
        return "\(year(calendar))-\(month(calendar))-\(day(calendar))"
    }
    func getTime() -> String{
        let calendar = Calendar.current
        return "\(hour(calendar)):\(minute(calendar)):\(second(calendar))"
    }
    func getFullDate() -> String{
        return "\(getDate()) \(getTime())"
    }
}
