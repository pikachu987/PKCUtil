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

// AppVersion
public struct AppVersion{
    /// appStore url
    public var url: String
    /// currentVersion
    public var currentVersion: String
    /// appStore version
    public var storeVersion: String
    /// isUpdate
    public var isUpdate: Bool
    /// version Between depth
    public var depth: Int = -1
    
    public init(url: String, currentVersion: String, storeVersion: String, isUpdate: Bool) {
        self.url = url
        self.currentVersion = currentVersion
        self.storeVersion = storeVersion
        self.isUpdate = isUpdate
    }
}

// AppStore
public class AppStore: NSObject {
    // MARK: func
    
    /**
     version Check
     - parameter identifier: String?
     - parameter handler: (AppVersion) -> Void
     */
    public static func versionCheck(_ identifier: String? = nil, handler: @escaping (AppVersion) -> Void){
        // current version
        let currentVer = Util.nsVersion
        
        let bundleIdentifierValue = identifier ?? Bundle.main.bundleIdentifier
        // appStore server
        guard let bundleIdentifier = bundleIdentifierValue, let url = NSURL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)") else{
            return
        }
        
        enum UpdateType{
            case none, update, noneUpdate
        }
        
        var updateType: UpdateType = .none
        let task = URLSession.shared.dataTask(with: url as URL) {(data, response, error) in
            do{
                guard let json = data, let dict = try JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary else{
                    return
                }
                guard let results :NSArray = dict["results"] as? NSArray, results.count != 0 else{ return }
                guard let dic = results[0] as? NSDictionary else{ return }
                
                guard let trackViewUrl = dic["trackViewUrl"] as? String else{ return }
                guard let version = dic["version"] as? String else{ return }
                
                let currentVersion = currentVer
                
                if currentVersion != version{
                    let versionArr = version.components(separatedBy: ".")
                    let currentVersionArr = currentVersion.components(separatedBy: ".")
                    let componentCnt = versionArr.count < currentVersionArr.count ? versionArr.count: currentVersionArr.count
                    for index in 0 ..< componentCnt{
                        if let av = Int(versionArr[index]), let cv = Int(currentVersionArr[index]){
                            if av > cv{
                                updateType = .update
                                break
                            }else if av < cv{
                                updateType = .noneUpdate
                                break
                            }
                        }
                    }
                    if updateType == .none{
                        if versionArr.count > currentVersionArr.count{
                            updateType = .update
                        }else{
                            updateType = .noneUpdate
                        }
                    }
                }else{
                    updateType = .noneUpdate
                }
                if updateType == .update{
                    // update
                    var version = AppVersion(url: trackViewUrl, currentVersion: currentVersion, storeVersion: version, isUpdate: true)
                    
                    
                    // depth
                    let currentComponent = version.currentVersion.components(separatedBy: ".")
                    let storeComponent = version.storeVersion.components(separatedBy: ".")
                    let componentsCnt = currentComponent.count
                    if componentsCnt != storeComponent.count{
                        version.depth = 0
                    }else{
                        for element in 0..<componentsCnt{
                            if currentComponent[element] < storeComponent[element]{
                                version.depth = element
                                break
                            }
                        }
                    }
                    
                    handler(version)
                }else{
                    // non update
                    handler(AppVersion(url: trackViewUrl, currentVersion: currentVersion, storeVersion: version, isUpdate: false))
                }
            }catch let err{
                print(err)
                handler(AppVersion(url: "", currentVersion: currentVer, storeVersion: currentVer, isUpdate: false))
            }
        }
        task.resume()
    }
}

