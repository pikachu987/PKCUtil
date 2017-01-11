//
//  PhotoAlbumCustom.swift
//  Jundan
//
//  Created by guanho on 2016. 5. 6..
//  Copyright © 2016년 guanho. All rights reserved.
//

import Foundation
import Photos
import AssetsLibrary

enum PhotoAlbumUtilResult {
    case success, error, denied
}

class PhotoAlbumUtil: NSObject {
    
    class func saveImageInAlbum(_ image: UIImage, albumName: String, completion: ((_ result: PhotoAlbumUtilResult) -> ())?) {
        
        // 사진첩 폴더 생성
        var eventAlbum: PHAssetCollection?
        let albumName = albumName
        let albums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: nil)
        albums.enumerateObjects(options: .concurrent, using: { (album, index, stop) in
            if album.localizedTitle == albumName {
                eventAlbum = album as PHAssetCollection
                stop.pointee = true
            }
        })
        
        //폴더 생성 유무 확인
        //첫 생성 시 eventAlbum == nil
        
        if eventAlbum != nil {
            completion?(.denied)
        }else{
            //eventAlbum == nil 경우 폴더 생성
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
                }, completionHandler: { (succeeded, error) -> Void in
                    
                    if succeeded {
                        //성공 시 폴더 생성 후 함수 재호출
                        self.saveImageInAlbum(image, albumName: albumName, completion: completion)
                        
                    } else {
                        // 에러
                        completion?(.error)
                    }
            })
        }
        
        // 생성 확인 됐을 시 이미지 저장 작업
        if let albumdex = eventAlbum {
            
            PHPhotoLibrary.shared().performChanges({
                let result = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let assetPlaceholder = result.placeholderForCreatedAsset
                let albumChangeRequset = PHAssetCollectionChangeRequest(for: albumdex)
                let enumeration: NSArray = [assetPlaceholder!]
                albumChangeRequset!.addAssets(enumeration)
                
                }, completionHandler: { (succeeded, error) -> Void in
                    if succeeded {
                        completion?(.success)
                    } else{
                        print(error!.localizedDescription)
                        completion?(.error)
                    }
            })
        }
    }
}
