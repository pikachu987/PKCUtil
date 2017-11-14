//
//  Storage.swift
//  Jundan
//
//  Created by guanho on 2016. 4. 8..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation
import UIKit

open class Storage{
    //스트로지 저장
    open static func setStorage(_ key : String, value : AnyObject){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    //스트로지 꺼내기
    open static func getStorage(_ key : String) -> AnyObject?{
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    
    //스트로지 삭제
    open static func removeStorage(_ key : String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
