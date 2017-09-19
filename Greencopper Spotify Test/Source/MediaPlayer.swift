//
//  MediaPlayer.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import Foundation

class MediaPlayer: NSObject {
    
    static let shared = MediaPlayer()
    private override init() {}
    
    var player: SPTAudioStreamingController?
    
    func playPlaylist(url: String) {
        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
            
        })
    }
    
    func configurePlayer(authSession:SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player?.start(withClientId: LoginManager.shared.clientId)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
}

extension MediaPlayer: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
            
        })
        
    }
}
