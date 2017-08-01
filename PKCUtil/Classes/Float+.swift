//
//  Float+.swift
//  Pods
//
//  Created by pikachu987 on 2017. 8. 1..
//
//

import Foundation

extension Float{
    func priceComma() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let pointValue = numberFormatter.string(from: NSNumber(value: self)){
            return pointValue
        }else{
            return "0"
        }
    }
}
