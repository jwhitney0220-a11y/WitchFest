import Foundation

public struct CardInstance: Identifiable, Equatable {
    public let id: UUID
    public let definition: CardDefinition

    public var currentHealth: Int
    public var currentWard: Int
    public var currentPower: Int

    public init(id: UUID = UUID(), definition: CardDefinition) {
        self.id = id
        self.definition = definition
        self.currentHealth = definition.baseHealth
        self.currentWard = definition.baseWard
        self.currentPower = definition.basePower
    }

    public var cost: Int {
        definition.cost
    }
}
