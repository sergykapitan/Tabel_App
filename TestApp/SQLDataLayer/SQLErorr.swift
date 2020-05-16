//
//  SQLErorr.swift
//  TestApp
//
//  Created by Sergey Koriukin on 16/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation

enum SQLiteError: Error {
  case OpenDatabase(message: String)
  case Prepare(message: String)
  case Step(message: String)
  case Bind(message: String)
    case Delete(message: String)
}
