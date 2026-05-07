import Foundation

public struct CardDefinition: Codable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let cost: Int
    public let family: String?
    public let baseHealth: Int
    public let baseWard: Int
    public let basePower: Int
    public let isTier3: Bool

    public init(id: String, name: String, cost: Int, family: String? = nil, baseHealth: Int = 0, baseWard: Int = 0, basePower: Int = 0, isTier3: Bool = false) {
        self.id = id
        self.name = name
        self.cost = cost
        self.family = family
        self.baseHealth = baseHealth
        self.baseWard = baseWard
        self.basePower = basePower
        self.isTier3 = isTier3
    }
}
