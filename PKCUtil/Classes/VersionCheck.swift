//
//  VersionCheck.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 11. 14..
//

import Foundation
import UIKit

public struct AppVersion{
    var url: String
    var currentVersion: String
    var storeVersion: String
    var isUpdate: Bool
}


public class AppStore: NSObject {
    
    public static func version(_ handler: @escaping (AppVersion) -> Void){
        //현재 버전
        let currentVer = PKCUtil.nsVersion
        //통신할 앱서버
        guard let bundleIdentifier = Bundle.main.bundleIdentifier, let url = NSURL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)") else{
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
                    handler(AppVersion(url: trackViewUrl, currentVersion: currentVersion, storeVersion: version, isUpdate: true))
                }else{
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
