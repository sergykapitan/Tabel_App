//
//  Woker.swift
//  TestApp
//
//  Created by Sergey Koriukin on 15/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation
import SQLite

protocol SQLTable {
  static var createStatement: String { get }
}

struct Woker {
      let id: Int32
      let name: NSString
    }

extension Woker: SQLTable {
  static var createStatement: String {
    return """
    CREATE TABLE Contact(
      id integer PRIMARY KEY,
      Name CHAR(255)
    );
    """
  }
}
