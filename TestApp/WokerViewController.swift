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
        navigationItemBar()
        SQLProvider.connect()
        self.navigationController?.setNavigationBarHidden(false, animated: true) //SHow
    }
    
    //MARK: Navigation
    func navigationItemBar() {
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addNewNote(_:)))
    }

    @objc func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "EditorWokerSegue", sender: nil)
    }

}
