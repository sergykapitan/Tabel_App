//
//  ExtensionViewController+.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentOkAllert(title: String, message: String? = nil, completeion:((UIAlertAction) -> Void)?
    = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: completeion)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
