//
//  LoginViewController.swift
//  BipolarDiary
//
//  Created by Jonatan Ortiz on 02/03/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeIconButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        backItem.tintColor = .lightGray
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController")
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        backItem.tintColor = .lightGray
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

