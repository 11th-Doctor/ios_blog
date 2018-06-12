//
//  ViewController.swift
//  ios_blog
//
//  Created by Daryl on 2018/6/9.
//  Copyright © 2018 Daryl. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    var list = ["AAA"]
    var app = UIApplication.shared.delegate as! AppDelegate
    var postColllectionData:[[String:Any]] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        app.postsData.setDelegate(self)
        let navigationVc = UINavigationController()
        navigationVc.title = "AA"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //Labels
        let titleLabel = cell.viewWithTag(100) as? UILabel
        let bodyLabel = cell .viewWithTag(200) as? UILabel
        let readMoreBtn = cell .viewWithTag(300) as? UIButton
        bodyLabel?.numberOfLines = 0
        
        let item = postColllectionData[indexPath.row]
        
        var title = "unKnown"
        var body = "unKnown"
        var created_at = "unKnown"
        
        if item["title"] is String {
            title = item["title"] as! String
        }
        
        if item["body"] is String {
            body = item["body"] as! String
//            let begin = body.index(body.startIndex, offsetBy: 0)
//            let end = body.index(body.startIndex, offsetBy: 20)
//            body = String(body[begin...end])
        }
        
        if item["created_at"] is Dictionary<String, AnyObject> {
            let subItem = item["created_at"] as! Dictionary<String, AnyObject>
            created_at = subItem["date"] as! String
            let begin = created_at.index(created_at.startIndex, offsetBy: 0)
            let end = created_at.index(created_at.startIndex, offsetBy: 15)
            created_at = String(created_at[begin...end])
        }
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font : UIFont.boldSystemFont(ofSize: CGFloat(24))])
        attributedText.append(NSAttributedString(string: "\n\(created_at)  台中市 · ", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(15)),NSAttributedStringKey.foregroundColor:UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe-Small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 20, height: 20)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        titleLabel?.attributedText = attributedText
        bodyLabel?.text = body
        
        return cell
    }
    
    var PostTitle: String? = nil
    var created_at: String? = nil
    var body: String? = nil
    var id: String? = nil
    
    
    
    func invokeMeWhenDataIsDone() {
        postColllectionData = app.postsData.getPostColllectionData()
        collectionView.reloadData()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CollectionVC_to_PostVC" {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                
                let item = postColllectionData[indexPath[0].row]
                
                if item["title"] is String, item["body"] is String,
                    item["id"] is Int, item["created_at"] is Dictionary<String, AnyObject> {
                    PostTitle = (item["title"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
                    body = (item["body"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
                    id = String(item["id"] as! Int).trimmingCharacters(in: .whitespacesAndNewlines)
//
                    let subItem = item["created_at"] as! Dictionary<String, AnyObject>
                    
                    created_at = (subItem["date"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    guard created_at != nil else {
                        return false
                    }
                    let begin = created_at?.index((created_at?.startIndex)!, offsetBy: 0)
                    let end = created_at?.index((created_at?.startIndex)!, offsetBy: 15)
                    
                    created_at = String((created_at?[begin!...end!])!)
                    return true
                }
                return false
            }
            return false
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionVC_to_PostVC" {
            let vc = segue.destination as! PostViewController
            vc.PostTitle = PostTitle
            vc.body = body
            vc.created_at = created_at
            vc.id = id
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

