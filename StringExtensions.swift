//
//  SwiftMD5.swift
//  Logave
//
//  Created by Alex on 06.09.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

extension String {
    func md5() -> String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    
    func splitToArray() -> [Double]{
        let fullNameArr = self.characters.split{$0 == ","}.map(String.init)
        let longitude:Double = fullNameArr[0].toDouble()!
        let latitude:Double = fullNameArr[1].toDouble()!
        return [longitude,latitude]
    }
}
