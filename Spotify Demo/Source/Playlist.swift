//
//  Playlist.swift
//  Greencopper Spotify Test
//
//  Created by Wojtek Frątczak on 2017-09-20.
//  Copyright © 2017 Wojtek. All rights reserved.
//

import Foundation

enum Playlist {
    case kanye, drake, kungFury, weeknd
    
    var title: String {
        switch self {
        case .kanye: return "Kanye West - Graduation"
        case .drake: return "Drake - Views"
        case .kungFury: return "Kung Fury - Moview soundrack"
        case .weeknd: return "The Weeknd - Starboy"
        }
    }
    
    var urlString: String {
        switch self {
        case .kanye: return "spotify:album:3SZr5Pco2oqKFORCP3WNj9"
        case .drake: return "spotify:album:40GMAhriYJRO1rsY4YdrZb"
        case .kungFury: return "spotify:album:7FVPCO3NlVMdVgybfAPD2z"
        case .weeknd: return "spotify:album:2ODvWsOgouMbaA5xf0RkJe"
        }
    }
}
