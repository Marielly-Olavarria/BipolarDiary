//
//  ForgotPasswordViewController.swift
//  BipolarDiary
//
//  Created by Jonatan Ortiz on 03/03/22.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    var alert = UIAlertController()
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = email
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        //enviar email
    }
    
}
