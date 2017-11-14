//
//  NSDate.swift
//  ClubfulIOS
//
//  Created by guanho on 2016. 8. 21..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation


public extension Date{
    //year 숫자로 가져오기
    public func yearInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.year, from: self)
        let year = components.year
        return year
    }
    
    
    //month 숫자로 가져오기
    public func monthInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.month, from: self)
        let month = components.month
        return month
    }
    
    
    //day 숫자로 가져오기
    public func dayInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.day, from: self)
        let day = components.day
        return day
    }
    
    
    
    
    //hour 숫자로 가져오기
    public func hourInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        return hour
    }
    
    
    //minute 숫자로 가져오기
    public func minuteInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        return minute
    }
    
    //second 숫자로 가져오기
    public func secondInt(_ calendar : Calendar = Calendar.current) -> Int?{
        let components = (calendar as NSCalendar).components(.second, from: self)
        let second = components.second
        return second
    }
    
    
    
    
    
    
    
    
    
    //year 문자열로 가져오기
    public func year(_ calendar : Calendar = Calendar.current, defaultValue: String = "1991") -> String{
        guard let value = yearInt(calendar) else {
            return defaultValue
        }
        return "\(value)"
    }
    
    //month 문자열로 가져오기
    public func month(_ calendar : Calendar = Calendar.current, defaultValue: String = "06") -> String{
        guard let value = monthInt(calendar) else {
            return defaultValue
        }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    //day 문자열로 가져오기
    public func day(_ calendar : Calendar = Calendar.current, defaultValue: String = "21") -> String{
        guard let value = dayInt(calendar) else {
            return defaultValue
        }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    //hour 문자열로 가져오기
    public func hour(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = hourInt(calendar) else {
            return defaultValue
        }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    //minute 문자열로 가져오기
    public func minute(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = minuteInt(calendar) else {
            return defaultValue
        }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    //second 문자열로 가져오기
    public func second(_ calendar : Calendar = Calendar.current, defaultValue: String = "00") -> String{
        guard let value = secondInt(calendar) else {
            return defaultValue
        }
        return value < 10 ? "0\(value)" : "\(value)"
    }
    
    
    
    
    //풀 데이트 뽑기
    public func getFullDate(_ dateOf: String = "-", timeOf: String = ":") -> String{
        let calendar = Calendar.current
        return "\(getDate(calendar, of: dateOf)) \(getTime(calendar, of: timeOf))"
    }
    
    //default: yyyy-MM-dd 형식으로 날짜 뽑기
    public func getDate(_ calendar : Calendar = Calendar.current, of: String = "-") -> String{
        return "\(year(calendar))\(of)\(month(calendar))\(of)\(day(calendar))"
    }
    
    //default: HH:mm:ss 형식으로 날짜 뽑기
    public func getTime(_ calendar : Calendar = Calendar.current, of: String = ":") -> String{
        return "\(hour(calendar))\(of)\(minute(calendar))\(of)\(second(calendar))"
    }
    
    
    
    
    
    
    //날짜,시간 Tuple로 하나하나 뽑기
    public func getDateTupleInt() -> (Int?, Int?, Int?, Int?, Int?, Int?){
        let calendar = Calendar.current
        return (yearInt(calendar), monthInt(calendar), dayInt(calendar), hourInt(calendar), minuteInt(calendar), secondInt(calendar))
    }
    
    //날짜, 시간 문자열 Tuple로 뽑기
    public func getDateTuple() -> (String, String, String, String, String, String){
        let calendar = Calendar.current
        return (year(calendar), month(calendar), day(calendar), hour(calendar), minute(calendar), second(calendar))
    }
    
    
    
    
    
    
    
    
    
    //날짜 사이 구하기
    public func daysBetweenDate(_ toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    
    
    
    
    
    
    
    
    
    //금일과 같으면 시간, 다르면 날짜 보여주기
    public func getDispalyRegDate(_ dateOf: String = ".", morning: String, afternoon: String) -> String{
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
                return "\(afternoon) \(hourStr):\(self.minute())"
            }else{
                var hourStr = "0\(hour)"
                if hour > 9{
                    hourStr = "\(hour)"
                }
                return "\(morning) \(hourStr):\(self.minute())"
            }
        }else{
            return self.getDate(of: dateOf)
        }
    }
    
    
    
    
    
    
    //현재시간 밀리세컨드로
    public var millisecondsSince1970: String {
        let date = (self.timeIntervalSince1970 * 1000.0).rounded()
        let value = "\(date)"
        if let milliseconds = value.split(separator: ".").first{
            return "\(milliseconds)"
        }
        return "\(value)"
    }
    
    public init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    
    
    
    
    //나이 구하기
    public var age: Int {
        get {
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: self, to: now)
            guard let age = ageComponents.year else{
                return 0
            }
            return age
        }
    }
    
    
    
    //년도 비교
    public func equalYear(_ date: Date) -> Bool{
        return self.year() == date.year() ? true : false
    }
    
    //년도, 월 비교
    public func equalMonth(_ date: Date) -> Bool{
        return (self.equalYear(date) && self.month() == date.month()) ? true : false
    }
    
    //년도, 월, 일 비교
    public func equalDate(_ date: Date) -> Bool{
        return (self.equalMonth(date) && self.day() == date.day()) ? true : false
    }
    
    
    
}
