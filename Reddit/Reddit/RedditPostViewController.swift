//
//  ViewController.swift
//  Reddit
//
//  Created by William Moody on 5/22/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        WILRedditPostController.shared().fetchPost { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                print("FAIL")
            }
        }
        // Do any additional setup after loading the view.
    }
}

extension RedditPostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WILRedditPostController.shared().posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = WILRedditPostController.shared().posts[indexPath.row]
        
        WILRedditPostController.shared().fetchImage(from: post) { (image) in
            cell.imageView?.image = image
        }
        
        cell.textLabel?.text = post.title
        
        
        return cell
    }
    
    
}
