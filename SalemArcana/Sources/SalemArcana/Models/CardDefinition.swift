import Foundation

public struct StatRoll: Codable, Equatable {
    public let healthMin: Int
    public let healthMax: Int
    public let damageMin: Int
    public let damageMax: Int
}

public struct TargetingInfo: Codable, Equatable {
    public let mode: String
    public let priority: [String]
}

public struct EffectBlock: Codable, Equatable {
    public let type: String
    public let amount: Int
    public let vfx: String?
    public let timing: String?
}

public struct HookData: Codable, Equatable {
    public let canDropActive: Bool
    public let activeDropChance: Double
    public let unlockCurrency: String
    public let unlockCost: Int
    public let awakeningRecipeTags: [String]
}

public struct CardDefinition: Codable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let family: String?
    public let tier: Int
    public let cost: Int

    // Additional schema attributes from PDF 11.1
    public let statRoll: StatRoll?
    public let keywords: [String]?
    public let targeting: TargetingInfo?
    public let onReveal: [EffectBlock]?
    public let persistent: [EffectBlock]?
    public let hookEligible: Bool?
    public let hook: HookData?

    // Legacy support for base stats directly if statRoll isn't used
    public let baseHealth: Int
    public let baseWard: Int
    public let basePower: Int
    public let isTier3: Bool

    public init(
        id: String, name: String, cost: Int, family: String? = nil, tier: Int = 1,
        statRoll: StatRoll? = nil, keywords: [String]? = nil, targeting: TargetingInfo? = nil,
        onReveal: [EffectBlock]? = nil, persistent: [EffectBlock]? = nil,
        hookEligible: Bool? = nil, hook: HookData? = nil,
        baseHealth: Int = 0, baseWard: Int = 0, basePower: Int = 0, isTier3: Bool = false
    ) {
        self.id = id
        self.name = name
        self.cost = cost
        self.family = family
        self.tier = tier

        self.statRoll = statRoll
        self.keywords = keywords
        self.targeting = targeting
        self.onReveal = onReveal
        self.persistent = persistent
        self.hookEligible = hookEligible
        self.hook = hook

        self.baseHealth = baseHealth
        self.baseWard = baseWard
        self.basePower = basePower
        self.isTier3 = isTier3
    }
}
