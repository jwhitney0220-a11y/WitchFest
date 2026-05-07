import Foundation

public struct Deck {
    public var cards: [CardInstance]

    public init(cards: [CardInstance] = []) {
        self.cards = cards
    }

    public mutating func shuffle(using rng: inout DeterministicRNG) {
        guard !cards.isEmpty else { return }
        for i in stride(from: cards.count - 1, through: 1, by: -1) {
            let j = rng.next(upperBound: i + 1)
            cards.swapAt(i, j)
        }
    }

    public mutating func draw(count: Int) -> [CardInstance] {
        let drawCount = min(count, cards.count)
        guard drawCount > 0 else { return [] }
        let drawn = Array(cards.prefix(drawCount))
        cards.removeFirst(drawCount)
        return drawn
    }
}
