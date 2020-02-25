//
//  Lobby.swift
//  SwiftNest
//
//  Created by Haoyuan Tang on 25/2/20.
//

import Foundation

public class Lobby: MatchingGroup {
    override func join(player: Player) -> Bool {
        if super.join(player: player) {
            //TODO Notify a new player has joined this lobby
            return true
        } else {
            //TODO Notify the player failed to join this lobby
            return false
        }
    }
    
    override func leave(player: Player) -> Bool {
        if super.leave(player: player) {
            //TODO Notify a player has left this lobby
            return true
        } else {
            //TODO Notify the player doesn't exist in this lobby
            return false
        }
    }
    
    override func dismiss() {
        for (_, player) in players {
            //TODO Notify all players that this lobby is being dismissed
        }
    }
}
