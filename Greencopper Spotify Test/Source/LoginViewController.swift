//
//  LoginViewController.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: View config
    
    private func configureView() {
        LoginManager.shared.delegate = self
        configureLoginButton()
        view.backgroundColor = .spotifyBackground
    }
    
    private func configureLoginButton() {
        let buttonWidth = view.frame.width - 100.0
        let buttonFrame = CGRect(x: (view.bounds.width - buttonWidth)/2, y: view.bounds.height/2, width: buttonWidth, height: 50)
        let button = UIButton(frame: buttonFrame)
        button.backgroundColor = UIColor.spotifyGreen
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        view.addSubview(button)
    }
    
    // MARK: Login handling
    
    @IBAction func loginAction(sender: UIButton) {
        LoginManager.shared.login()
    }
}

extension LoginViewController: LoginManagerDelegate {
    func loginManagerDidLoginWithSuccess() {
        dismiss(animated: true, completion: nil)
    }
}
