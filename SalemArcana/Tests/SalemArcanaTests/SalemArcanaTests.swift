import XCTest
@testable import SalemArcana

final class SalemArcanaTests: XCTestCase {
    func testWitchfireCurve() throws {
        XCTAssertEqual(TurnState.witchfireForRound(1), 2)
        XCTAssertEqual(TurnState.witchfireForRound(6), 7)
        XCTAssertEqual(TurnState.witchfireForRound(7), 7)
    }

    func testMultiCardPlayBudget() throws {
        var turn = TurnState(round: 3)
        let _ = turn.startTurn() // base 4
        XCTAssertEqual(turn.availableWitchfire, 4)
        try turn.playCard(cost: 1)
        try turn.playCard(cost: 2)
        XCTAssertEqual(turn.availableWitchfire, 1)
        XCTAssertEqual(turn.cardsPlayedThisTurn, 2)

        XCTAssertThrowsError(try turn.playCard(cost: 2)) { error in
            XCTAssertEqual(error as? PlayError, PlayError.notEnoughWitchfire)
        }
    }

    func testPatienceCountdown() throws {
        var turn = TurnState(round: 1)
        let _ = turn.startTurn()
        turn.endTurn() // 0 cards played
        XCTAssertEqual(turn.patienceCountdown, 2)

        let _ = turn.startTurn()
        try turn.playCard(cost: 1)
        turn.endTurn() // 1 card played
        XCTAssertEqual(turn.patienceCountdown, 2) // Shouldn't decrease

        let _ = turn.startTurn()
        turn.endTurn() // 0 cards played -> 1
        let _ = turn.startTurn()
        turn.endTurn() // 0 cards played -> 0 -> isPatient
        XCTAssertEqual(turn.patienceCountdown, 0)
        XCTAssertTrue(turn.isPatient)
    }

    func testOvertimeCalculation() throws {
        var match = MatchState()
        match.playerSealInfluence = 100
        match.opponentSealInfluence = 102
        XCTAssertTrue(match.evaluateOvertime()) // Diff 2, margin 2/102 <= 0.05

        match.opponentSealInfluence = 110
        XCTAssertFalse(match.evaluateOvertime()) // Diff 10, margin 10/110 = 0.09 > 0.05
    }

    func testDeckDrawing() throws {
        var rng = DeterministicRNG(seed: 123)
        let def = CardDefinition(id: "test", name: "TestCard", cost: 1)
        var deck = Deck(cards: [
            CardInstance(definition: def),
            CardInstance(definition: def),
            CardInstance(definition: def)
        ])

        let hand = deck.draw(count: 2)
        XCTAssertEqual(hand.count, 2)
        XCTAssertEqual(deck.cards.count, 1)
    }
}
