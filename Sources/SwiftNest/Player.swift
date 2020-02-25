//
//  Player.swift
//  CNIOAtomics
//
//  Created by Haoyuan Tang on 25/2/20.
//

import Foundation
import NIO

public class Player {
    public private(set) var id: String!
    var context: ChannelHandlerContext!
    
    public private(set) var startMatching: Int64
    
    init() {
        self.startMatching = 0
    }
}

extension Player: MatchingUnit {
    public var numOfPlayers: Int {
        return 1
    }
}

extension Player: PartyMember {
    public func PartyDismissed() {
        print("The party is dismissed.")
    }
}
