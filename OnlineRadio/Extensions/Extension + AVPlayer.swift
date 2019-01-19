//
//  Extension + AVPlayer.swift
//  OnlineRadio
//
//  Created by Артём Балашов on 19/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
