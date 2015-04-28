//
//  LegislatorsTableViewController.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 4/27/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import UIKit
class LegislatorsTableViewController: UITableViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *****SIDEBAR*****
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 170
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // *****REFRESH*****
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshComplete"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //called by refreshControl
    func refresh(){
        
    }
    //called by data-getting classes when they finish
    func refreshComplete(){
        self.tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        refreshControl?.endRefreshing()
    }
}