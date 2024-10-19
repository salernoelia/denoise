import SwiftUI
import RealityKit
import RealityKitContent
import UmainSpatialGestures



@MainActor
@Observable
class AppModel: ObservableObject {
    
    
    let elevatorRideID = "ElevatorRide"
    let galaxyID = "Galaxy"
    
    // MARK: - Elevator
    var isShowingElevator: Bool = false
    
    
    // MARK: - Universe
    var isShowingUniverse: Bool = false
    
    var elevatorIsOccupied: Bool = false
    
    
    enum ElevatorRideState: CaseIterable {
        case openEntranceDoorsNotEntered
        case closedEntranceDoors
        case openEntranceDoorsEntered
        case closingEntranceDoors
        case elevatorStart
        case introduction
        case introductionAnimation
        case closingIntroductionAnimation
        case beforeUniverseInterception
        case elevatorUniverseLoad
        case universeInteraction
        case closingUniverseInteraction
        case spawnResearchLab
        case elevatorStop
        case openExitDoors
        case dismissResearchLab
        case inTransition
        
        var displayName: String {
            switch self {
            case .inTransition: return "In Transition"
            case .openEntranceDoorsNotEntered: return "Open Entrance Doors Not Entered"
            case .openEntranceDoorsEntered: return "Open Entrance Doors"
            case .closedEntranceDoors: return "Closed Entrance Doors"
            case .closingEntranceDoors: return "Closing Entrance Doors"
            case .elevatorStart: return "Elevator Start"
            case .introduction: return "Introduction"
            case .introductionAnimation: return "Introduction Animation"
            case .closingIntroductionAnimation: return "Closing Introduction Animation"
            case .beforeUniverseInterception: return "Before Universe Interception"
            case .elevatorUniverseLoad: return "Load universe"
            case .universeInteraction: return "Universe Interaction"
            case .closingUniverseInteraction: return "Closing Universe Interaction"
            case .spawnResearchLab: return "Spawn Research Lab"
            case .elevatorStop: return "Elevator Stop"
            case .openExitDoors: return "Open Exit Doors"
            case .dismissResearchLab: return "Dismiss Research Lab"
            }
        }
    }
    
    private var rideSequenceTask: Task<Void, Never>? = nil
    
    
    var elevatorRideState: ElevatorRideState = .openEntranceDoorsNotEntered  {
        didSet {
            Task {
                
            }
        }
    }
    
    /*
    /// Starts the elevator ride sequence. Transitions are handled in seconds.
    func startElevatorRideSequence() {
        rideSequenceTask?.cancel()
        
        rideSequenceTask = Task {
            await transition(to: .closingEntranceDoors, after: 0)
            await transition(to: .closedEntranceDoors, after: 5)
            await transition(to: .elevatorStart, after: 5)
            await transition(to: .introduction, after: 5)
            await transition(to: .introductionAnimation, after: 10)
            await transition(to: .closingIntroductionAnimation, after: 15)
            await transition(to: .beforeUniverseInterception, after: 2)
            await transition(to: .elevatorUniverseLoad, after: 15)
            await transition(to: .universeInteraction, after: 10)
            await transition(to: .closingUniverseInteraction, after: 180)
            await transition(to: .spawnResearchLab, after: 1)
            await transition(to: .elevatorStop, after: 15)
            await transition(to: .openExitDoors, after: 5)
            await transition(to: .dismissResearchLab, after: 10)
            await transition(to: .openEntranceDoorsNotEntered, after: 10)
        }
    }*/
    
    /// Stops the elevator ride sequence.
    func stopElevatorRideSequence() {
        rideSequenceTask?.cancel()
        rideSequenceTask = nil
        elevatorRideState = .closedEntranceDoors
    }
    
    
    
    
    /// Transitions to a new state after a specified delay.
    private func transition(to state: ElevatorRideState, after seconds: Double) async {
        do {
            try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            // Check if the task is still active before setting the state
            if !Task.isCancelled {
                self.elevatorRideState = state
            }
        } catch {
            // Handle cancellation or other errors if necessary
            print("Transition to \(state.displayName) was cancelled or failed: \(error)")
        }
    }
    
    /*
    /// Handles actions based on the new state.
    private func handleStateChange(_ state: ElevatorRideState) async {
        switch state {
        case .openEntranceDoorsNotEntered:
            handleOpenEntranceDoorsNotEntered()
        case .closedEntranceDoors:
            handleClosedEntranceDoors()
        case .openEntranceDoorsEntered:
            await handleOpenEntranceDoors()
        case .closingEntranceDoors:
            handleClosingEntranceDoors()
        case .elevatorStart:
            handleElevatorStart()
        case .introduction:
            await handleIntroduction()
        case .introductionAnimation:
            handleIntroductionAnimation()
        case .closingIntroductionAnimation:
            handleClosingIntroductionAnimation()
        case .beforeUniverseInterception:
             handleBeforeUniverseInterception()
        case .elevatorUniverseLoad:
            handleElevatorUniverseLoad()
        case .universeInteraction:
            handleUniverseInteraction()
        case .closingUniverseInteraction:
            handleClosingUniverseInteraction()
        case .spawnResearchLab:
            handleSpawnResearchLab()
        case .elevatorStop:
            handleElevatorStop()
        case .openExitDoors:
            handleOpenExitDoors()
        case .dismissResearchLab:
            handleDismissResearchLab()
        case .inTransition:
            handleInTransition()
        }
    }
    
    // MARK: - State Handlers
    
    private func handleOpenEntranceDoorsNotEntered() {
        print("doors open not entered")
    }
    
    private func handleClosedEntranceDoors()  {
        print("Handling Closed Entrance Doors")
        isShowingElevator = true
        
        
        
    }
    
    private func handleOpenEntranceDoors() async {
        print("Handling Open Entrance Doors")
        // await denoiseApp().dismissImmersiveSpace()
    }
    
    private func handleClosingEntranceDoors() {
        print("Handling Closing Entrance Doors")
    }
    
    private func handleElevatorStart() {
        print("Handling Elevator Start")
    }
    
    private func handleIntroduction() async {
        isShowingUniverse = true
        print("Handling Introduction")
        
        //print("ElevatorImmersiveView", ElevatorImmersiveView())
        // print("ElevatorImmersiveView self", ElevatorImmersiveView().self)
        //await ElevatorImmersiveView().handleAddGalaxy()
        
    }
    
    private func handleIntroductionAnimation() {
        print("Handling Introduction Animation")
    }
    
    private func handleClosingIntroductionAnimation() {
        print("Handling Closing Introduction Animation")
    }
    
    private func handleBeforeUniverseInterception() {
        print("Handeling Before Universe Interception")
    }
    
    private func handleElevatorUniverseLoad() {
        print("Handling Elevator Universe")
    }
    
    private func handleUniverseInteraction() {
        print("Handling Universe Interaction")
    }
    
    private func handleClosingUniverseInteraction() {
        print("Handling Closing Universe Interaction")
    }
    
    private func handleSpawnResearchLab() {
        print("Handling Spawn Research Lab")
        print(denoiseApp())
    }
    
    private func handleElevatorStop() {
        print("Handling Elevator Stop")
    }
    
    private func handleOpenExitDoors() {
        print("Handling Open Exit Doors")
    }
    
    private func handleDismissResearchLab() {
        print("Handling Dismiss Research Lab")
    }
    
    private func handleInTransition() {
        print("Handling In Transition")
    }*/
}
