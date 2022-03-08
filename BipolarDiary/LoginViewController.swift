//
//  LoginViewController.swift
//  BipolarDiary
//
//  Created by Jonatan Ortiz on 02/03/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeIconButton: UIButton!
    
    var showPassword: Bool = false
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        vc.email = emailTextField.text!
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        backItem.tintColor = .lightGray
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func togglePasswordVisibility(_ sender: Any) {
        showPassword.toggle()
        if showPassword {
            passwordTextField.isSecureTextEntry = false
            eyeIconButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            eyeIconButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
                if error != nil {
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        switch errorCode {
                        
                        case .invalidEmail:
                            alert = UIAlertController(title: "EMAIL INVÁLIDO!", message: "Digite um email válido.", preferredStyle: .alert)
                            self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                            present(alert, animated: true, completion: nil)
                        
                        case .wrongPassword:
                           alert = UIAlertController(title: "SENHA INCORRETA!", message: "Digite sua senha novamente.", preferredStyle: .alert)
                           self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                          present(alert, animated: true, completion: nil)
                        
                        default:
                            alert = UIAlertController(title: "ERRO AO EFETUAR O LOGIN!", message: "Por favor tente novamente.", preferredStyle: .alert)
                            self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                            present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // FAZER A NAVEGAÇÃO PARA A HOME
                    print("deu certo")
                }
            }
        } else {
            alert = UIAlertController(title: "ATENÇÃO!", message: "Todos os campos devem ser preenchidos.", preferredStyle: .alert)
            self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        vc.email = emailTextField.text!
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        backItem.tintColor = .lightGray
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
