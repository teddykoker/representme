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
 
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var termlengthLabel: UILabel!
    @IBOutlet weak var fullName: UINavigationItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phonelabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

 
    
   
    
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
       
        birthdayLabel.text = leader.birthday
        fullName.title = leader.firstName + " " + leader.lastName
       
        termlengthLabel.text = leader.term_start + " until " + leader.term_end
        phonelabel.text = leader.phone
        websiteLabel.text = leader.website
        
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
    
    
   }
