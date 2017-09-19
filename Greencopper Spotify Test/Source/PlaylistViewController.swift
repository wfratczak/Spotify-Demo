//
//  PlaylistViewController.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    var playlistUri: String?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        checkSession()
        
        loadPlaylist()
    }
    
    // MARK: Session check
    
    private func loadPlaylist() {
        guard LoginManager.shared.isLogged else {return}
        
    }
    
    private func checkSession() {
        if !LoginManager.shared.isLogged {
            let loginVC = LoginViewController()
            present(loginVC, animated: true, completion: nil)
        }
    }
    
    // MARK: View config
    
    private func configureView() {
        navigationController?.navigationBar.barTintColor = UIColor.spotifyBackground
        view.backgroundColor = UIColor.spotifyBackground
        
    }
    
    private func configurePlayerView() {
        let playerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        playerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
    }
    
    private func configureTableView() {
        
    }
    
}
