//
//  LeadersList.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 5/5/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//

import Foundation
class LeadersList {
    
    class var list : LeadersList {
        struct Singleton {
            static let instance = LeadersList()
        }
        return Singleton.instance;
        
    }
    private(set) var leaders:[Leader]
    private var selected: Int
    
    init(){
        leaders = []
        selected = 0
    }
    func setLeaders(l:[Leader]){
        leaders = l
    }
    func setSelected(index: Int){
        selected = index
    }

}
