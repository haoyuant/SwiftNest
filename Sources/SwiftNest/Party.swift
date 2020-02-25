//
//  Party.swift
//  SwiftNest
//
//  Created by Tekt Haoyuan Tang on 25/2/20.
//

import Foundation

public enum PartyStatus {
    case idle, matching, playing, dismissed
}

public class Party: MatchingGroup {
    public private(set) var status: PartyStatus
    public private(set) var startMatching: Int64
    
    override init(host: Player, quota: Int) {
        self.status = .idle
        self.startMatching = 0
        super.init(host: host, quota: quota)
    }
    
    override func join(player: Player) -> Bool {
           if super.join(player: player) {
               //TODO Notify a new player has joined this party
               return true
           } else {
               //TODO Notify the player failed to join this praty
               return false
           }
       }
       
       override func leave(player: Player) -> Bool {
           if super.leave(player: player) {
               //TODO Notify a player has left this party
               return true
           } else {
               //TODO Notify the player doesn't exist in this party
               return false
           }
       }
       
       override func dismiss() {
           for (_, player) in players {
               //TODO Notify all players that this party is being dismissed
           }
       }
}

extension Party: MatchingUnit {}
