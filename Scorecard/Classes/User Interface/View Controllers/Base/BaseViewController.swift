//
//  BaseViewController.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

// NOTE: Subclass this for every ViewController
class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupConstranits()
    }
    
    // MARK: - UI
    
    func initUI() {
        
    }
    
    func setupConstranits() { /* Override in child if needed */ }
}
