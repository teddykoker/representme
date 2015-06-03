//
//  DataList.swift
//  RepresentMe_beta
//
//  Created by Teddy Koker on 5/5/15.
//  Copyright (c) 2015 Teddy Koker. All rights reserved.
//
import Foundation
class DataList {
    
    class var list : DataList {
        struct Singleton {
            static let instance = DataList()
        }
        return Singleton.instance;
        
    }
    private(set) var leaders:[Leader]
    private(set) var bills: [Bill]
    private(set) var selectedLeader: Int
    private(set) var selectedBill: Int
    
    init(){
        leaders = []
        bills = []
        selectedLeader = 0
        selectedBill = 0
    }
    func setLeaders(l:[Leader]){
        leaders = l
    }
    func setBills(b:[Bill]){
        bills = b 
    }
    func setSelectedLeader(index: Int){
        selectedLeader = index
    }
    func setSelectedBill(index: Int){
        selectedBill = index
    }

}
