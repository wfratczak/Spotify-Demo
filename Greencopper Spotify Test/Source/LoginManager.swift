//
//  LoginManager.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import Foundation

protocol LoginManagerDelegate: class {
    func loginManagerDidLoginWithSuccess()
}

class LoginManager {
    
    static var shared = LoginManager()
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessAction), name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
        let redirectURL = "https://www.greencopper.com/" // put your redirect URL here
        let clientID = "924afc65c280462987b83222d1fea17d" // put your client ID here
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    weak var delegate: LoginManagerDelegate?
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession?
    var loginUrl: URL?
    var clientId: String {
        return auth.clientID
    }
    var isLogged: Bool {
        if let session = session {
            return session.isValid()
        }
        return false
    }
    
    @objc func loginSuccessAction() {
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            MediaPlayer.shared.configurePlayer(authSession: firstTimeSession)
        }
        
    }
    
    func login() {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
    
}
