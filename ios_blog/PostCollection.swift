//
//  PostCollection.swift
//  ios_blog
//
//  Created by Daryl on 2018/6/10.
//  Copyright © 2018 Daryl. All rights reserved.
//

import UIKit

class PostCollection: NSObject {
    private var postColllectionData:[[String:Any]] = []
    
    func loadJsonData () {
        if let url = URL(string: "http://localhost:8000/resource/posts") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, AnyObject>
                postColllectionData = response["data"] as! [[String : Any]]
                
            } catch {
                print(error)
            }
        }
    }
    
    func setDelegate(_ vc: ViewController) {
        
        vc.invokeMeWhenDataIsDone()
    }
    
    func getPostColllectionData() -> [[String:Any]] {
        return postColllectionData
    }
}
