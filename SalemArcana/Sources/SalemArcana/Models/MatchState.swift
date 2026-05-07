import Foundation

public struct MatchState {
    public var turnState: TurnState

    public var playerSealInfluence: Int
    public var opponentSealInfluence: Int

    public init(round: Int = 1) {
        self.turnState = TurnState(round: round)
        self.playerSealInfluence = 0
        self.opponentSealInfluence = 0
    }

    public mutating func evaluateOvertime() -> Bool {
        let high = max(playerSealInfluence, opponentSealInfluence)
        let margin = Double(abs(playerSealInfluence - opponentSealInfluence)) / Double(max(high, 1))
        return margin <= 0.05
    }
}
