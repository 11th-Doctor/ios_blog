//
//  PostViewController.swift
//  ios_blog
//
//  Created by Daryl on 2018/6/11.
//  Copyright © 2018 Daryl. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var PostTitle: String? = nil
    var created_at: String? = nil
    var body: String? = nil
    var id: String? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bodyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard PostTitle != nil, created_at != nil, body != nil else {
            return
        }
        
        titleLabel.text = PostTitle
        dateLabel.textColor = UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)
        dateLabel.text = created_at
        
        bodyTextView.attributedText = NSAttributedString(string: body!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(20))])
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
