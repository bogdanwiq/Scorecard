//
//  StatisticsViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/15/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import HMKit
import FBSDKLoginKit
import PasscodeLock

class StatisticViewController: BaseViewController {
    
    let service = DataService.sharedInstance
    let reuseIdentifier : String = "DashboardCell"
    var tableView : UITableView!
    let timeFrame = TimeFrame()
    var originalMetricStats : [MetricModel] = []
    var projectDifferenceAndPercent : [String: [String: (Int, Double)]] = [:]
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
    
    override func initUI() {
        
        presentPasscodeScreen()
        
        let profileButton = Button.Profile.getButton()
        profileButton.addTarget(self, action: #selector(slideLeft), forControlEvents: .TouchUpInside)
        let notificationButton = Button.Notification.getButton()
        notificationButton.addTarget(self, action: #selector(notificationTapped), forControlEvents: .TouchUpInside)
        
        view.backgroundColor = Color.mainBackground
        title = "Dashboard"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        timeFrame.delegate = self
        timeFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeFrame)
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = Color.mainBackground
        tableView.registerClass(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let actInd = UIActivityIndicatorView()
        actInd.hidesWhenStopped = true
        actInd.center = view.center
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        actInd.color = Color.timeFrameSelected
        view.addSubview(actInd)
        actInd.startAnimating()
        performAsync {
            self.originalMetricStats = self.service.setupStats()
            performOnMainThread({
                actInd.stopAnimating()
                self.tableView.alpha = 0.0
                UIView.animateWithDuration(1.0, animations: {() -> Void in
                    self.tableView.reloadData()
                    self.tableView.alpha = 1.0
                })
            })
        }
    }
    
    func presentPasscodeScreen() {
        
        var passcodeKey: String
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            passcodeKey = FBSDKAccessToken.currentAccessToken().userID
        } else {
            passcodeKey = GIDSignIn.sharedInstance().clientID
        }
        passcodeKey += "pass"
        
        let configuration = PasscodeLockConfiguration(passcodeKey: passcodeKey)
        if configuration.repository.hasPasscode {
            let passcodeLockVC = PasscodeLockViewController(state: .EnterPasscode, configuration: configuration)
            presentViewController(passcodeLockVC, animated: true, completion: nil)
        }
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let views : [String: UIView] = ["timeFrame": timeFrame, "tableView": tableView]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[timeFrame]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[timeFrame(30)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func slideLeft() {
        mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func getTimeFrame() -> String {
        var timeFrameString : String!
        switch timeFrame.selectedIndex {
        case 0 :
            timeFrameString = "1d"
            break
        case 1 :
            timeFrameString = "1w"
            break
        case 2 :
            timeFrameString = "1m"
            break
        case 3 :
            timeFrameString = "1y"
            break
        case 4 :
            timeFrameString = "All"
            break
        default :
            timeFrameString = "All"
            break
        }
        return timeFrameString
    }
    
    func notificationTapped() {
        navigationController?.pushViewController(NotificationViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        
        selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
        navigationController?.pushViewController(DetailedStatisticViewController(metricId: originalMetricStats[indexPath.row].id, timeFrame: timeFrame.selectedIndex), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalMetricStats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let timeFrame = getTimeFrame()
        let cell : DashboardCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DashboardCell
        let currentMetric = originalMetricStats[indexPath.row]
        let valueAndPercent = currentMetric.timeframe[timeFrame]!
        let previousValue = Double(valueAndPercent.value) / (1 + valueAndPercent.percent / 100.0)
        let difference = Double(valueAndPercent.value) - previousValue
        
        cell.typeName.text = currentMetric.name
        cell.counter.text = String(currentMetric.timeframe[timeFrame]!.value.prettyString())
        if difference < 0 {
            cell.difference.text = "\(Int(difference).prettyString())"
            cell.difference.textColor = Color.statsFall
            cell.percent.textColor = Color.statsFall
            cell.percent.text = String(format: "%.2f",valueAndPercent.percent) + "%"
            cell.sign.image = EvolutionSign.ArrowDown.getSign()
        }
        else if difference == 0 {
            cell.difference.text = ""
            cell.difference.textColor = Color.textColor
            cell.percent.textColor = Color.textColor
            cell.percent.text = ""
            cell.sign.image = EvolutionSign.None.getSign()
        }
        else if difference > 0 {
            cell.difference.text = "+\(Int(difference).prettyString())"
            cell.difference.textColor = Color.statsRise
            cell.percent.textColor = Color.statsRise
            cell.percent.text = String(format: "+%.2f",valueAndPercent.percent) + "%"
            cell.sign.image = EvolutionSign.ArrowUp.getSign()
        }
        
        var hue : CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        Color.mainBackground.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        cell.backgroundColor = UIColor(hue: hue, saturation: saturation-(0.06*CGFloat(indexPath.row)), brightness: brightness+(0.03*CGFloat(indexPath.row)), alpha: alpha)
        return cell
    }
}

// MARK - TimeFrameDelegate

extension StatisticViewController: TimeFrameDelegate {
    
    func timeFrameSelectedValue(selectedIndex: Int) {
        tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
    }
}