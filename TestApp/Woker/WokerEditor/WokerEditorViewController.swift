//
//  WokerEditorViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 16/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import UIKit

class WokerEditorViewController: UIViewController {
    
      var db: SQLiteDatabase?
    
//    init(db: SQLiteDatabase) {
//        self.db = db
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItemBar()
    }
    
   

    
    // MARK: - Navigation

    func navigationItemBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(insertTODataBase(_:)))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    @objc func insertTODataBase(_ sender: Any) {
        
        do {
            try db?.insertContact(contact: Woker(id: 1, name: "Ray"))
             navigationController?.popViewController(animated: true)
        } catch {
            print(db!.errorMessage)
            
        } catch {
            print("some error")
        }
    }
    
    
    
}

