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

        print(UIDevice.current.modelNameType)
        print(PKCUtil.deviceId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension UIDevice{
    public var modelName: String {
        var systemInfo = utsname()
        _ = uname(&systemInfo)
        let machineString = Mirror(reflecting: systemInfo.machine).children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return self.modelName(machineString: machineString)
    }

    public var modelNameType: UIDeviceModelType {
        var systemInfo = utsname()
        _ = uname(&systemInfo)
        let machineString = Mirror(reflecting: systemInfo.machine).children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return self.modelNameType(machineString: machineString)
    }
}
