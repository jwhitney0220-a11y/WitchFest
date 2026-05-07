import SwiftUI

public struct AppShell: View {
    public init() {}

    public var body: some View {
        VStack {
            Text("Salem Arcana Beta")
                .font(.largeTitle)
                .padding()

            SpriteKitBattleScenePlaceholder()
        }
    }
}
