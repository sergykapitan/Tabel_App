//
//  WokerViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import UIKit
import SQLite3

class WokerViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        SQLProvider.connect()
        print("Woker work")
       
    }
    


}
