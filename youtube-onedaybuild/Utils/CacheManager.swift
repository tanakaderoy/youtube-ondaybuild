//
//  CacheManager.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/26/20.
//

import Foundation


class CacheManager  {
    static var cache  =  [String:Data]()
    static func setVideoCache(_ url: String, _ data: Data){
        cache[url]  = data
    }

    static func getVideoCache (_ url:String)  -> Data?{
        return cache[url]
    }
}
