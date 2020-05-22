//
//  WokerViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import UIKit
import SQLite3
import SQLite

class WokerViewController: UIViewController {
    
  //  let path = tutorialDirectoryUrl!
//
//
//    let db2 = try Connection("\(path)/db.sqlite3")
    
  //  let path2 = NSSearchPathForDirectoriesInDomains(
  //      .documentDirectory, .userDomainMask, true
 //   ).first!

   // let db2 = try! Connection("\(path)/db.sqlite3")

    
  //  let users = Table("Contact")
  //  let id = Expression<Int64>("id")
    var db: SQLiteDatabase!
    var tableView: UITableView = UITableView()
    var cellReuseIdentifier = "WokerEditorReuseId"
    
 
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        tableView.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
       print(#function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.reloadData()
        setupTableView()
        navigationItemBar()
        openDataBase()
        createTable()
        
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
    func createTable() {
        do {
          try db.createTable(table: Woker.self)
        } catch {
          print(db.errorMessage)
        }
    }
  
   func setupTableView() {
       tableView.frame = CGRect(x: 0, y: 50, width: 320, height: 200)
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

       self.view.addSubview(tableView)
   }
   
    
    //MARK: - Navigation
    func navigationItemBar() {
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addNewNote(_:)))
    }

    @objc func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "EditorWokerSegue", sender: nil)
    }

}
    //MARK: - Extension
extension WokerViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        if let first1 = db.contact(id: 5){
        cell.textLabel?.text = first1.name as String?
        }
        return cell
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            do {
               try? db.delete(id: 5)
              //  tableView.deleteRows(at: [indexPath], with: .none)
                try? db.update()
                self.tableView.reloadData()
               print("delete")
            }
            catch {
               print(db!.errorMessage)
            }
            self.tableView.reloadData()
        }
    }
    
}
