//
//  MatchingGroup.swift
//  SwiftNest
//
//  Created by Haoyuan Tang on 25/2/20.
//

import Foundation

public class MatchingGroup {
    public private(set) var id: UUID
    public private(set) var quota: Int = 0
    public private(set) var host: Player
    
    public var numOfPlayers: Int {
        return players.count
    }
    
    var players: [String: Player]
    
    init(host: Player, quota: Int) {
        self.id = UUID()
        self.host = host
        self.quota = quota
        self.players = [String: Player]()
        self.players[host.id] = host
    }
    
    func join(player: Player) -> Bool {
        if numOfPlayers < quota {
            players[player.id] = player
            return true
        } else {
            print("The party is full, cannot invite new member.")
            return false
        }
    }
    
    func leave(player: Player) -> Bool {
        return players.removeValue(forKey: player.id) != nil
    }
    
    func dismiss() {}
}
