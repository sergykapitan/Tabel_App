//
//  Model.swift
//  TestApp
//
//  Created by Sergey Koriukin on 15/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation
import SQLite

protocol Model: Equatable, Codable {
    associatedtype KeyType: Value where KeyType.Datatype: Equatable
    var identifier: KeyType { get }
}

extension Model where KeyType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
