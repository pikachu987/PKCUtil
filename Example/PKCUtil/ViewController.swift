//
//  ViewController.swift
//  PKCUtil
//
//  Created by pikachu987 on 01/12/2017.
//  Copyright (c) 2017 pikachu987. All rights reserved.
//

import UIKit
import PKCUtil

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Date().yearInt(): \(Date().yearInt())")
        print("Date().monthInt(): \(Date().monthInt())")
        print("Date().dayInt(): \(Date().dayInt())")
        print("Date().hourInt(): \(Date().hourInt())")
        print("Date().minuteInt(): \(Date().minuteInt())")
        print("Date().secondInt(): \(Date().secondInt())")
        
        print("Date().year(): \(Date().year())")
        print("Date().month(): \(Date().month())")
        print("Date().day(): \(Date().day())")
        print("Date().hour(): \(Date().hour())")
        print("Date().minute(): \(Date().minute())")
        print("Date().second(): \(Date().second())")
        print("Date().getDate(): \(Date().getDate())")
        print("Date().getTime(): \(Date().getTime())")
        print("Date().getFullDate(): \(Date().getFullDate())")
        
        print("substring: \("aaa".substring(from: 0, to: 2))")
        print("substring: \("aaa".substring(from: 0, length: 2))")
        print("range: \("aaa".range())")
        print("queryValue: \("aaa".queryValue())")
        
        print("init: \(UIColor(hex: 0xffffff))")
        print("init: \(UIColor(red: 100, green: 100, blue: 100))")
        print("redValue: \(UIColor(red: 100, green: 100, blue: 100).redValue)")
        print("greenValue: \(UIColor(red: 100, green: 100, blue: 100).greenValue)")
        print("blueValue: \(UIColor(red: 100, green: 100, blue: 100).blueValue)")
        print("alphaValue: \(UIColor(red: 100, green: 100, blue: 100).alphaValue)")
    
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(btn)
        btn.addAction(.touchUpInside) { (_) in
            print("btn Touch")
        }
        UIFont.printFontNames()
        for element in UIFont.fontNames(){
            print("element: \(element)")
        }
        
        print(Util.language)
        print(Util.nsVersion)
        print(Util.deviceId)
        print(Util.screenSize)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

