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
    var datagetter: DataGetter!
    var leaderList: LeadersList!
    
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
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        datagetter = DataGetter()
        leaderList = LeadersList.list
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //called by refreshControl
    func refresh(){
        datagetter.update(self)
    }
    //called by data-getting classes when they finish
    func refreshComplete(){
        self.tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        refreshControl?.endRefreshing()
    }
    
    
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderList.leaders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! UITableViewCell
        
        let leader = leaderList.leaders[indexPath.row] as Leader
        cell.textLabel!.text = leader.lastName
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false //for now not editable
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}