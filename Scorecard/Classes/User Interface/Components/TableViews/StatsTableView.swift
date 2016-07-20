//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsTableView : UITableView, UITableViewDataSource, UITableViewDelegate{
    
    //Variables
    var arrayOfStats : [Stats] = [Stats]()
    //End Variables
    
   

    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.frame = UIScreen.mainScreen().bounds
        self.delegate      =   self
        self.dataSource    =   self
        self.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")
        self.setupArray()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupArray(){
        let array1 = Stats(typeName: "Download", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let array2 = Stats(typeName: "Update", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        
        arrayOfStats.append(array1)
        arrayOfStats.append(array2)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfStats.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell = CustomCell()
        let reuseIdentifier = "cell"
        let cell : CustomCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCell
        
        
        // cell.typeName.text = arrayOfStats[indexPath.row].typeName
        //        cell.counter.text = String(arrayOfStats[indexPath.row].counter)
        //        cell.difference.text = String(arrayOfStats[indexPath.row].difference)
        //        cell.percent.text = String(arrayOfStats[indexPath.row].percent)
        //cell.sign = arrayOfStats[indexPath.row].getImage()
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(arrayOfStats[indexPath.row])
    }
    
}