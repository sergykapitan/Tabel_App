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
    
    var db: SQLiteDatabase!
    var tableView: UITableView = UITableView()
    var cellReuseIdentifier = "WokerEditorReuseId"
    
   // let animals =
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        setupTableView()
        tableView.reloadData()
        let first2 = db.contact(id: 1)
        print(first2?.name as Any)
    }
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        print(#function)
        let first = db.contact(id: 1)
        print(first?.name as Any)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.reloadData()
        setupTableView()
        navigationItemBar()
        openDataBase()
        
    }
    //MARK: - OpenDataBase
    func openDataBase() {
        

        do {
            db = try SQLiteDatabase.open(path: part2DbPath!)
            print("Successfully opened connection to database.")
        }  catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        }  catch {
            print("some error")
        }
    }
   func setupTableView() {
       tableView.frame = CGRect(x: 0, y: 50, width: 320, height: 200)
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

       self.view.addSubview(tableView)
   }
   
    
    //MARK: Navigation
    func navigationItemBar() {
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addNewNote(_:)))
    }

    @objc func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "EditorWokerSegue", sender: nil)
    }

}
extension WokerViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        let first1 = db.contact(id: 1)
        print(first1?.name)
        cell.textLabel?.text = first1?.name as String?

        return cell
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
}
