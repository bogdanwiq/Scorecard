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
    
    var arrayOfStats : [Stats] = [Stats]()
    let reuseIdentifier : String = "cell"
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.frame = UIScreen.mainScreen().bounds
        self.delegate      =   self
        self.dataSource    =   self
        self.rowHeight = UITableViewAutomaticDimension
        self.registerClass(CustomCell.self, forCellReuseIdentifier: "cell")
        self.setupArray()
        self.separatorColor = UIColor.clearColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupArray(){
        let array1 = Stats(typeName: "DOWNLOAD", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let array2 = Stats(typeName: "UPDATE", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        let array3 = Stats(typeName: "USERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let array4 = Stats(typeName: "DOWNLOADERS", counter: 1231, difference: 22, percent: 10, sign: "None")
        let array5 = Stats(typeName: "ITERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let array6 = Stats(typeName: "Update", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        let array7 = Stats(typeName: "DOWNLOADERS", counter: 1231, difference: 22, percent: 10, sign: "None")
        let array8 = Stats(typeName: "ITERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let array9 = Stats(typeName: "Update", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        
        arrayOfStats.append(array1)
        arrayOfStats.append(array2)
        arrayOfStats.append(array3)
        arrayOfStats.append(array4)
        arrayOfStats.append(array5)
        arrayOfStats.append(array6)
        arrayOfStats.append(array7)
        arrayOfStats.append(array8)
        arrayOfStats.append(array9)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfStats.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        backgroundColor = UIColorFromHex(kBackgroundColor)
        let cell : CustomCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCell
        
        // SET UILABELS.TEXT
        cell.typeName.text = arrayOfStats[indexPath.row].typeName
        cell.counter.text = String(arrayOfStats[indexPath.row].counter)
        if arrayOfStats[indexPath.row].getImage() == UIImage(named: "ArrowUp"){
            cell.difference.textColor = UIColorFromHex(kRiseColor)
            cell.difference.text = "+" + String(arrayOfStats[indexPath.row].difference)
        }else if arrayOfStats[indexPath.row].getImage() == UIImage(named: "ArrowDown"){
            cell.difference.textColor = UIColorFromHex(kFallColor)
            cell.difference.text = "-" + String(arrayOfStats[indexPath.row].difference)
        }
        else if arrayOfStats[indexPath.row].getImage() == UIImage(named: "None"){
            cell.difference.textColor = UIColorFromHex(kRiseColor)
            cell.difference.text = String(arrayOfStats[indexPath.row].difference)
        }
        cell.percent.text = String(arrayOfStats[indexPath.row].percent) + "%"
        cell.sign.image = arrayOfStats[indexPath.row].getImage()
        
        // CELL BACKGROUND COLOR
        var hue : CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        UIColorFromHex(kBackgroundColor).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        cell.backgroundColor = UIColor(hue: hue, saturation: saturation-(0.06*CGFloat(indexPath.row)), brightness: brightness+(0.03*CGFloat(indexPath.row)), alpha: alpha)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        print(arrayOfStats[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}