//
//  AllTVC.swift
//  ios_blog
//
//  Created by Daryl on 2018/6/12.
//  Copyright © 2018 Daryl. All rights reserved.
//

import UIKit

class AllTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let app = UIApplication.shared.delegate as! AppDelegate
    var postColllectionData:[[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        app.postsData.setDelegate(self)
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postColllectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = postColllectionData[indexPath.row]
        
        var title = "unKnown"
        var body = "unKnown"
        var created_at = "unKnown"
        
        if item["title"] is String {
            title = item["title"] as! String
        }
        
        if item["body"] is String {
            body = item["body"] as! String
            let begin = body.index(body.startIndex, offsetBy: 0)
            let end = body.index(body.startIndex, offsetBy: 20)
            body = String(body[begin...end])
        }
        
        if item["created_at"] is Dictionary<String, AnyObject> {
            let subItem = item["created_at"] as! Dictionary<String, AnyObject>
            created_at = subItem["date"] as! String
            let begin = created_at.index(created_at.startIndex, offsetBy: 0)
            let end = created_at.index(created_at.startIndex, offsetBy: 15)
            created_at = String(created_at[begin...end])
        }
        
        cell.textLabel?.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "\(title) - ", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(17))])
        attributedText.append(NSAttributedString(string: body, attributes: [:]))
        attributedText.append(NSAttributedString(string: "\n\(created_at)  台中市 · ", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(15)),NSAttributedStringKey.foregroundColor:UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe-Small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 20, height: 20)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        cell.textLabel?.attributedText = attributedText

        return cell
    }

    
    func invokeMeWhenDataIsDone() {
        postColllectionData = app.postsData.getPostColllectionData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
