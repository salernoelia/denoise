import RealityKit

// Ensure you register this component in your app’s delegate using:
// AnchorEntityComponent.registerComponent()
public struct AnchorEntityComponent: Component {
    public var anchorEntity: AnchorEntity

    // The initializer must be isolated to the main actor due to the async nature of AnchorEntity's init
    @MainActor
    public init() {
        self.anchorEntity = AnchorEntity() // Safely initialize within the main actor
    }
}

// Extension to add this component to any entity
extension Entity {
    @MainActor
    func addAnchorEntityComponent() {
        let component = AnchorEntityComponent() // Must be called within the main actor context
        self.components.set(component)
    }

    @MainActor
    func attachEntity(_ entity: Entity) {
        // Ensure the entity has an anchor component
        if let anchorComponent = self.components[AnchorEntityComponent.self] {
            anchorComponent.anchorEntity.addChild(entity)
        }
    }
}
