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

public protocol QueueingUnit {
    var numOfPlayers: Int { get }
}

public class Party {
    var id: UUID
    var quota: Int
    var leader: Player
    var status: PartyStatus
    
    var numOfPlayers: Int {
        return players.count
    }
    
    private var players: [String: Player]
    
    init(leader: Player, quota: Int) {
        self.id = UUID()
        self.leader = leader
        self.quota = quota
        self.players = [String: Player]()
        self.players[leader.id] = leader
        self.status = .idle
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
    
    func dismiss() {
        for (_, player) in players {
            //TODO Notify players that the party has been dismissed
        }
    }
}
extension party: QueueingUnit {
}

public class Player {
    var id: String!
    
    init() {
    }
}

extension Player: QueueingUnit {
    public var numOfPlayers: Int {
        return 1
    }
}
