//
//  PlaylistViewController.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkSession()
    }

    // MARK: Session check
    
    private func checkSession() {
        if !LoginManager.shared.isLogged {
            let loginVC = LoginViewController()
            present(loginVC, animated: true, completion: nil)
        }
    }
    
    // MARK: View config

    private func configureView() {
        
    }
    
    private func configureTableView() {
        
    }
    
}
