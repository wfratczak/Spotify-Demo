//
//  MediaPlayer.swift
//  Greencopper Spotify Test
//
//  Created by Wojciech on 2017-09-18.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import Foundation

protocol MediaPlayerDelegate: class {
    func mediaPlayerDidFinishTrack()
    func mediaPlayerDidFail(error: Error)
    func mediaPlayerDidStartPlaying(track: SPTPartialTrack)
    func mediaPlayerDidPause()
    func mediaPlayerDidChange(trackProgress: Double)
    func mediaPlayerDidResume()
}

class MediaPlayer: NSObject {
    
    static let shared = MediaPlayer()
    private override init() {}
    weak var delegate: MediaPlayerDelegate?
    private var player: SPTAudioStreamingController?
    private (set) var currentTrack: SPTPartialTrack?
    var isPlaying: Bool {
        if let player = player,
            let state = player.playbackState {
            return state.isPlaying
        }
        return false
    }
    
    func loadAlbum(url: String, completion: @escaping (_ album: SPTAlbum?, _ error: Error?) -> Void) {
        SPTAlbum.album(withURI: URL(string: url), accessToken: LoginManager.shared.auth.session.accessToken, market: nil) { (error, response) in
            completion(response as? SPTAlbum, error)
        }
    }
    
    func play(track: SPTPartialTrack) {
        player?.playSpotifyURI(track.uri.absoluteString, startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if let error = error {
                self.delegate?.mediaPlayerDidFail(error: error)
            } else {
                self.currentTrack = track
                self.delegate?.mediaPlayerDidStartPlaying(track: track)
            }
        })
    }
    
    func seek(to progress: Float) {
        guard let current = currentTrack else {return}
        player?.seek(to: Double(progress) * current.duration, callback: { (error) in
            if let error = error {
                self.delegate?.mediaPlayerDidFail(error: error)
            }
        })
    }
    
    func resume() {
        player?.setIsPlaying(true, callback: { (error) in
            if let error = error {
                self.delegate?.mediaPlayerDidFail(error: error)
            } else {
                self.delegate?.mediaPlayerDidResume()
            }
        })
    }
    
    func pause() {
        player?.setIsPlaying(false, callback: { (error) in
            if let error = error {
                self.delegate?.mediaPlayerDidFail(error: error)
            } else {
                self.delegate?.mediaPlayerDidPause()
            }
        })
    }
    
    func configurePlayer(authSession:SPTSession, id: String) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player?.start(withClientId: id)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
}

extension MediaPlayer: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChangePosition position: TimeInterval) {
        delegate?.mediaPlayerDidChange(trackProgress: position/currentTrack!.duration)
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        print("logged in")
    }

    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStopPlayingTrack trackUri: String!) {
        delegate?.mediaPlayerDidFinishTrack()
    }
    
}
