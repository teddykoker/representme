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
    var dataList: DataList!
    var images: [UIImage]!
    
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
        
        // *****SETUP*****
        datagetter = DataGetter()
        dataList = DataList.list
        refresh()
       
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //called by refreshControl
    func refresh(){
        datagetter.updateLegs(self)
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
        return dataList.leaders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! UITableViewCell
        
       
        let leader = dataList.leaders[indexPath.row] as Leader
        cell.textLabel!.text = leader.lastName
        
        if let url = NSURL(string: "http://theunitedstates.io/images/congress/225x275/\(leader.bioguideId).jpg") {
            if let data = NSData(contentsOfURL: url){
                cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
                cell.imageView!.image = UIImage(data: data)
                cell.imageView!.layer.cornerRadius = 20.0
                
                cell.imageView!.clipsToBounds = true
                
                // Adding a border to the image profile
                cell.imageView!.layer.borderWidth = 5.0
                cell.imageView!.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
        
        
       
       
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tableViewCell = sender as! UITableViewCell!
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        dataList.setSelectedLeader(indexPath.row)
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
    
