//
//  BillTableViewController.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 4/27/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import UIKit
class BillTableViewController: UITableViewController{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var datagetter: DataGetter!
    var dataList: DataList!
    
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
        if dataList.billsFromLeader{
            self.title = "Sponsored by \(dataList.leaders[dataList.selectedLeader].lastName)"
            datagetter.updateBills(self, bioId: dataList.leaders[dataList.selectedLeader].bioguideId)
            dataList.setBillsFromLeader(false)
        }else{
            self.title = "Recent Bills"
        datagetter.updateBills(self)
        }
    }
    func refreshWithId(bioId: String){
        datagetter.updateBills(self, bioId: bioId)
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
        return dataList.bills.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! UITableViewCell
        let bill = dataList.bills[indexPath.row] as Bill
        cell.textLabel!.text = bill.official_title
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tableViewCell = sender as! UITableViewCell!
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        dataList.setSelectedBill(indexPath.row)
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