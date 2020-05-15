//
//  ExtensionViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOKAlert(title: String, message: String? = nil, completeion: ((UIAlertAction) -> Void)? = nil) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default, handler: completeion)
           alert.addAction(action)
           
           present(alert, animated: true)
       }
//       
//       func presentConfirmAlert(title: String, message: String? = nil, confirmHandler: @escaping (UIAlertAction) -> Void, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
//           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//           let confirmAction = UIAlertAction(title: "Подтвердить", style: .destructive, handler: confirmHandler)
//           let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: cancelHandler)
//           
//           alert.addAction(confirmAction)
//           alert.addAction(cancelAction)
//           present(alert, animated: true)
//       }
//       
//       func presentInFormSheet(viewController: UIViewController) {
//           let navigationController = UINavigationController(rootViewController: viewController)
//           navigationController.modalPresentationStyle = .formSheet
//           navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1686089337, green: 0.1686392725, blue: 0.1686022878, alpha: 1)
//           navigationController.navigationBar.tintColor = .white
//           navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//           if viewController.navigationItem.leftBarButtonItem == nil {
//               viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "error"), style: .plain, target: viewController, action: #selector(dismissFormSheetController))
//               viewController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.8881979585, green: 0.3072378635, blue: 0.2069461644, alpha: 1)
//           }
//           present(navigationController, animated: true)
//       }
//       
//       @objc private func dismissFormSheetController() {
//           dismiss(animated: true, completion: nil)
//       }
}


