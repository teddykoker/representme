//
//  UpdatesViewController.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 4/27/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import UIKit
class UpdatesViewController: UIViewController{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 170
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
