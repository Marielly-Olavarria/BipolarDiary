//
//  CreateAccountViewController.swift
//  BipolarDiary
//
//  Created by Jonatan Ortiz on 03/03/22.
//

import Foundation
import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordEyeIconButton: UIButton!
    @IBOutlet weak var confirmPasswordEyeIconButton: UIButton!
    
    var showPassword: Bool = false
    var showConfirmPassword: Bool = false
    var alert = UIAlertController()
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = email
    }
    
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        if sender.tag == 0 {
            showPassword.toggle()
            if showPassword {
                passwordTextField.isSecureTextEntry = false
                passwordEyeIconButton.setImage(UIImage(systemName: "eye"), for: .normal)
            } else {
                passwordTextField.isSecureTextEntry = true
                passwordEyeIconButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        } else {
            showConfirmPassword.toggle()
            if showConfirmPassword {
                confirmPasswordTextField.isSecureTextEntry = false
                confirmPasswordEyeIconButton.setImage(UIImage(systemName: "eye"), for: .normal)
            } else {
                confirmPasswordTextField.isSecureTextEntry = true
                confirmPasswordEyeIconButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        }
    }
    
    func firebaseCreateAccount(withEmail: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                        
                    case .invalidEmail:
                        alert = UIAlertController(title: "EMAIL INVÁLIDO!", message: "Digite um email válido.", preferredStyle: .alert)
                        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                        present(alert, animated: true, completion: nil)
                        
                    case .emailAlreadyInUse:
                        alert = UIAlertController(title: "EMAIL EM USO!", message: "Digite um novo email.", preferredStyle: .alert)
                        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                        present(alert, animated: true, completion: nil)
                        
                    case .weakPassword:
                        alert = UIAlertController(title: "SENHA FRACA!", message: "Crie uma nova senha.", preferredStyle: .alert)
                        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                        present(alert, animated: true, completion: nil)
                        
                    default:
                        alert = UIAlertController(title: "ERRO AO CRIAR CONTA!", message: "Por favor tente novamente.", preferredStyle: .alert)
                        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
                        present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                createAccountSuccess()
            }
        }
    }
    
    func createAccountSuccess() {
        alert = UIAlertController(title: "CONTA CRIADA COM SUCESSO!", message: "Seja bem vindo.", preferredStyle: .alert)
        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(alert, animated: true, completion: nil)
    }
    
    func emptyFields() {
        alert = UIAlertController(title: "ATENÇÃO!", message: "Todos os campos devem ser preenchidos.", preferredStyle: .alert)
        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(alert, animated: true, completion: nil)
    }
    
    func passwordDidNotMatch() {
        alert = UIAlertController(title: "ATENÇÃO!", message: "As senhas não conferem.", preferredStyle: .alert)
        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty {
            if password == confirmPassword {
                firebaseCreateAccount(withEmail: email, password: password)
            } else {
                passwordDidNotMatch()
            }
        } else {
            emptyFields()
        }
    }
    
}
