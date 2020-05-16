//
//  SQLiteDatabase.swift
//  TestApp
//
//  Created by Sergey Koriukin on 15/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation
import SQLite

class SQLiteDatabase {
    
    
    private let dbPointer: OpaquePointer?
   // var db: OpaquePointer?
    
    private init(dbPointer: OpaquePointer?) {
     self.dbPointer = dbPointer
   }
  
   var errorMessage: String {
    if let errorPointer = sqlite3_errmsg(dbPointer) {
      let errorMessage = String(cString: errorPointer)
      return errorMessage
    } else {
      return "No error message provided from sqlite."
    }
  }
  
  deinit {
    sqlite3_close(dbPointer)
  }
  
  static func open(path: String) throws -> SQLiteDatabase {
    var db: OpaquePointer?
    if sqlite3_open(path, &db) == SQLITE_OK {
      return SQLiteDatabase(dbPointer: db)
    } else {
      defer {
        if db != nil {
          sqlite3_close(db)
        }
      }
      if let errorPointer = sqlite3_errmsg(db) {
        let message = String(cString: errorPointer)
        throw SQLiteError.OpenDatabase(message: message)
      } else {
        throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
      }
    }
  }
}

extension SQLiteDatabase {
  func prepareStatement(sql: String) throws -> OpaquePointer? {
    var statement: OpaquePointer?
    guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
      throw SQLiteError.Prepare(message: errorMessage)
    }
    return statement
  }
}

extension SQLiteDatabase {
  func createTable(table: SQLTable.Type) throws {
    let createTableStatement = try prepareStatement(sql: table.createStatement)
    defer {
      sqlite3_finalize(createTableStatement)
    }
    guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("\(table) table created.")
  }
}
extension SQLiteDatabase {
  func insertContact(contact: Woker) throws {
    
    let insertSql = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"
    
    let insertStatement = try prepareStatement(sql: insertSql)
    
    defer {
      sqlite3_finalize(insertStatement)
    }
    let name: NSString = contact.name
    guard
      sqlite3_bind_int(insertStatement, 1, contact.id) == SQLITE_OK  &&
      sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil) == SQLITE_OK
      else {
        throw SQLiteError.Bind(message: errorMessage)
    }
    guard sqlite3_step(insertStatement) == SQLITE_DONE else {
      throw SQLiteError.Step(message: errorMessage)
    }
    print("Successfully inserted row.")
  }
}
extension SQLiteDatabase {
    
  func contact(id: Int32) -> Woker? {
    
    let querySql = "SELECT * FROM Contact WHERE Id = ?;"
    
    guard let queryStatement = try? prepareStatement(sql: querySql) else {
      return nil
    }
    defer {
      sqlite3_finalize(queryStatement)
    }
    guard sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK else {
      return nil
    }
    guard sqlite3_step(queryStatement) == SQLITE_ROW else {
      return nil
    }
    let id = sqlite3_column_int(queryStatement, 0)
    let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
    let name = String(cString: queryResultCol1!) as NSString
    return Woker(id: id, name: name)
  }
}
extension SQLiteDatabase {
    func delete(id: Int32) throws {
        
         let deleteSql = "DELETE FROM Contact WHERE Id = ?;"
         var deleteStatement: OpaquePointer?
         
         let queryStatement = try? prepareStatement(sql: deleteSql)
         defer {
           sqlite3_finalize(queryStatement)
         }
        
        guard
            sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK &&
            sqlite3_step(queryStatement) == SQLITE_DONE
        else {
            throw SQLiteError.Delete(message: errorMessage)    //Bind(message: errorMessage)
        }
        
    }
}
