//
//  LegislatorViewController.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 5/6/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import Foundation
import UIKit
class LegislatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var dataList: DataList!
    var leader: Leader!
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fullName: UINavigationItem!
    @IBOutlet weak var descriptionLabel: UILabel!
  

 
    
   
    
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
       
        self.configureView()
        super.viewDidLoad()
    }
    
    
    
    
    func configureView() {
        // Update the user interface for the detail item.
       
        //configuring all the labels
        dataList = DataList.list
        leader = dataList.leaders[dataList.selectedLeader]
       
        
        fullName.title = leader.firstName + " " + leader.lastName
        
        var partytitle = "  "
        var jobDescription = " "
        if(leader.party == "D"){
            partytitle = "Democratic"
        }else if(leader.party == "R"){
            partytitle = "Republican"
        }else if(leader.party == "I"){
            partytitle = "Independent"
        }
        
        if(leader.title == "Rep"){
            jobDescription = "Representative"
        }else if(leader.title == "Sen"){
            jobDescription = "Senator"
        }
        
        descriptionLabel.text = "\(partytitle) \(jobDescription) of \(leader.state)"

        
        
        
     
        let imgUrl = "http://theunitedstates.io/images/congress/225x275/\(leader.bioguideId).jpg"
       load_image(imgUrl)
        image.contentMode = UIViewContentMode.ScaleAspectFit
        
        image.layer.cornerRadius = 20.0
        
        image.clipsToBounds = true
        
        // Adding a border to the image profile
        image.layer.borderWidth = 2.0
        image.layer.borderColor = UIColor.whiteColor().CGColor

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDescriptionLabel(){
        var partytitle = "  "
        var jobDescription = " "
        if(leader.party == "D"){
            partytitle = "Democratic"
        }else if(leader.party == "R"){
            partytitle = "Republican"
        }else if(leader.party == "I"){
            partytitle = "Independent"
        }
        
        if(leader.title == "Rep"){
            jobDescription = "Representative"
        }else if(leader.title == "Sen"){
            jobDescription = "Senator"
        }
        
        descriptionLabel.text = "\(partytitle) \(jobDescription) of \(leader.state)"
        
    
    }
    
    func load_image(urlString:String){
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    self.image.image = UIImage(data: data)
                }
        })
        
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        dataList = DataList.list
        leader = dataList.leaders[dataList.selectedLeader]
        
        let tableCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
      
        
        switch(indexPath.row){
        case 0:
            tableCell.textLabel?.text = "Term"
            tableCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            tableCell.detailTextLabel!.text = leader.term_start + " until " + leader.term_end
            
        case 1:tableCell.textLabel?.text = "Birthday"
            tableCell.detailTextLabel!.text = leader.birthday
        tableCell.selectionStyle = UITableViewCellSelectionStyle.None

        case 2:tableCell.textLabel?.text = "Phone Number"
            tableCell.detailTextLabel!.text = leader.phone
            tableCell.selectionStyle = UITableViewCellSelectionStyle.None
            
        case 3:
            tableCell.detailTextLabel!.textColor = UIColor.blueColor()
            tableCell.textLabel?.textColor = UIColor.blueColor()
            tableCell.selectionStyle = UITableViewCellSelectionStyle.Blue
            tableCell.textLabel?.text = "Website"
            tableCell.detailTextLabel!.text = leader.website
            
            
        default:
        
            tableCell.textLabel?.text = "Website"
            tableCell.detailTextLabel!.text = leader.website
            tableCell.selectionStyle = UITableViewCellSelectionStyle.None
            

            
        }
        
        return tableCell
        
       
    
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if (indexPath.row == 3){
            UIApplication.sharedApplication().openURL(NSURL(string: leader.website)!)
        }else if(indexPath == 2){
            var url:NSURL = NSURL(string: "tel://9809088798")!
            UIApplication.sharedApplication().openURL(url)
        }
        
        
    }

    
    
   }
