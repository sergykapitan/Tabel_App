//
//  SQLProvider.swift
//  TestApp
//
//  Created by Sergey Koriukin on 15/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation
import SQLite3
import SQLite

class SQLProvider {
    
static private(set) var database: Connection!

    static func connect() {
    do {
        let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectory.appendingPathComponent("HDBMy").appendingPathExtension("sqlite3")
        database = try Connection(fileURL.path)
        print("Successful connection to DATABASE \(documentDirectory.path)")
        deployDBIfNeeded()
    } catch {
        print(error)
    }
  }
    static private func deployDBIfNeeded() {
    do {
        try database.execute("""
                    CREATE TABLE IF NOT EXISTS Worker (
            personnel_number integer PRIMARY KEY,
            login varchar(60) not null,
            password varchar(60) not null,
            surname varchar(30) not null,
            firstname varchar(30) not null,
            patronymic varchar(30) not null,
            avatar_image blob(500),
            sex char(1) not null check(sex = 'м' or sex = 'ж'),
            birthday date not null check(julianday("now") - julianday(birthday) > 365*18),
            marital_status varchar(30),
            address varchar(100) not null,
            education varchar(30) not null check(education in ("высшее", "бакалавр", "магитср", "неоконченное высшее", "среднее", "среднее специальное")),
            inn varchar(12) not null check(length(inn) == 12),
            start_date date not null check(julianday(start_date) <= julianday("now")),
            phone_number char(12) not null check(phone_number like "+7%" and length(phone_number) == 12),
            department integer not null,
            specialty varchar(30) not null ,
            employee_position integer not null,
            foreign key (department) references Department(id),
            foreign key (specialty) references Specialty(name),
            foreign key (employee_position) references EmployeePosition(id)
         );
         """)
            print("Successful DEPLOY")
        } catch {
            print(error)
        }
    }
    
    static func prepare(_ query: QueryType) ->  Swift.Result<AnySequence<Row>, Error>  {
        do {
            let queryResult = try database.prepare(query)
            return Swift.Result.success(queryResult)
        } catch {
            return Swift.Result.failure(error)
        }
    }
    
    static func execute<M: Model>(_ query: QueryType) -> [M] {
        let queryResult = prepare(query)
        if case .success(let rows) = queryResult {
            return (rows.compactMap({ try? M(from: $0.decoder()) }))
        }
        return []
    }
  
}
