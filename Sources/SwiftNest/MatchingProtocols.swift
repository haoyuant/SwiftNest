//
//  QueuingUnit.swift
//  SwiftNest
//
//  Created by Haoyuan Tang on 25/2/20.
//

import Foundation

public protocol MatchingUnit {
    var numOfPlayers: Int { get }
    var startMatching: Int64 { get }
}

public protocol PartyMember {
    func PartyDismissed()
}
