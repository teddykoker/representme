//
//  LegislatorViewController.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 5/6/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import Foundation
import UIKit
class LegislatorViewController: UIViewController{
    
    var dataList: DataList!
    var leader: Leader!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var termlengthLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        super.viewDidLoad()
    }
    func configureView() {
        dataList = DataList.list
        leader = dataList.leaders[dataList.selectedLeader]
        titleLabel.text = leader.title
        birthdayLabel.text = leader.birthday
        println(dataList.selectedLeader)
        
        
        
        
        // Update the user interface for the detail item.
        //let imgUrl = "http://theunitedstates.io/images/congress/225x275/\(leader.bioguideId).jpg"
        //loadImage(imgUrl)
        //http://theunitedstates.io/images/congress/[size]/[bioguide].jpg for picture use 450by550 or 225by275
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadImage(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    //This is your picture UIImage(data: data)
                }
        })
        
    }
}
