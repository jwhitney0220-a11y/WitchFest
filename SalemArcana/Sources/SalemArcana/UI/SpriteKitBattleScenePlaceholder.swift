import SwiftUI
import SpriteKit

public struct SpriteKitBattleScenePlaceholder: View {
    public init() {}

    var scene: SKScene {
        let scene = SKScene(size: CGSize(width: 300, height: 400))
        scene.backgroundColor = .darkGray
        let node = SKLabelNode(text: "Battle Scene Placeholder")
        node.position = CGPoint(x: 150, y: 200)
        scene.addChild(node)
        return scene
    }

    public var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 400)
            .border(Color.black)
    }
}
