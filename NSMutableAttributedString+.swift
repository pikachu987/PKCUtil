//
//  NSMutableAttributedString+.swift
//  PKCUtil
//
//  Created by docfriends on 2017. 10. 12..
//

import Foundation

public extension NSMutableAttributedString{
    public func attachment(_ name: String, rect: CGRect){
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        attachment.bounds = rect
        let attachmentString = NSAttributedString(attachment: attachment)
        self.append(attachmentString)
    }
}
