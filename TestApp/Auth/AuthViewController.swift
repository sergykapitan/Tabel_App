//
//  AuthViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fogotPasswordButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    
    //MARK: - Property
    let viewModel = AuthModel()
    
    //MARK: - ViewLifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func authActionButton(_ sender: Any) {
        let resultQwery = viewModel.signIn(withLogin: loginTextField.text!, password: passwordTextField.text!)
        
        switch resultQwery {
        case .failure(let error):
            presentOkAllert(title: error.localizedDescription)
        case .success(let userName):
            guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") else { return }
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true, completion: {
                self.presentOkAllert(title: "Добро пожаловать, \(userName)")
            })
        }
    }
    
    @IBAction func fogotPasswordButton(_ sender: Any) {
    }
  
}
