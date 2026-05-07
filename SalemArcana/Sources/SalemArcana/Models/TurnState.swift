import Foundation

public enum PlayError: Error {
    case notEnoughWitchfire
    case noLegalPlacement
}

public struct TurnState {
    public var round: Int
    public var baseWitchfire: Int
    public var bankedWitchfire: Int
    public var availableWitchfire: Int
    public var cardsPlayedThisTurn: Int
    public var patienceCountdown: Int
    public var isPatient: Bool

    public init(round: Int) {
        self.round = round
        self.bankedWitchfire = 0
        self.cardsPlayedThisTurn = 0
        self.patienceCountdown = 3
        self.isPatient = false
        self.baseWitchfire = TurnState.witchfireForRound(round)
        self.availableWitchfire = self.baseWitchfire
    }

    public static func witchfireForRound(_ round: Int) -> Int {
        switch round {
        case 1: return 2
        case 2: return 3
        case 3: return 4
        case 4: return 5
        case 5: return 6
        case 6: return 7
        default: return 7 // OT or beyond
        }
    }

    public mutating func startTurn() -> Int {
        self.baseWitchfire = TurnState.witchfireForRound(self.round)
        self.cardsPlayedThisTurn = 0
        self.availableWitchfire = self.baseWitchfire + (self.isPatient ? self.bankedWitchfire : 0)
        return self.isPatient ? 2 : 1 // returns drawCount
    }

    public mutating func playCard(cost: Int) throws {
        guard cost <= self.availableWitchfire else {
            throw PlayError.notEnoughWitchfire
        }
        self.availableWitchfire -= cost
        self.cardsPlayedThisTurn += 1
    }

    public mutating func endTurn() {
        if self.cardsPlayedThisTurn == 0 && !self.isPatient {
            self.patienceCountdown = max(0, self.patienceCountdown - 1)
            if self.patienceCountdown == 0 {
                self.isPatient = true
            }
        }
        self.bankedWitchfire = self.isPatient ? self.availableWitchfire : 0
    }
}
