//
//  LoginViewController.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {AuthResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    print(e.localizedDescription)
                } else{
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    
                }
            }
        }
        
    }
}
