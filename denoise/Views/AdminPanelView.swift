import SwiftUI

struct AdminPanelView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openElevatorSpace
    
    var body: some View {
        VStack { // Add spacing between buttons
            
            Text("Current ElevatorRideState: \(appModel.elevatorRideState)")
    /*
            Button("Start Elevator Ride Sequence") {
                appModel.startElevatorRideSequence()
                print("Starting Elevator Ride Sequence")
            }
            
            Button("Stop Elevator Ride Sequence") {
                appModel.stopElevatorRideSequence()
                print("Stopping Elevator Ride Sequence")
            }*/
            
            
            
   
            Button("Closed Entrance Doors") {
                appModel.elevatorRideState = .closedEntranceDoors
        /*
                print("State: \(appModel.elevatorRideState)")
                    Task { @MainActor in
                        if (
                            appModel.elevatorRideState != .closedEntranceDoors
                        ) {
                            switch await openElevatorSpace(id: appModel.elevatorRideID) {
                            case .opened:
                                break
                                
                            case .userCancelled, .error:
                                fallthrough
                            @unknown default:
                                appModel.elevatorRideState = .closedEntranceDoors
                            }
                    }
                }*/
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
          
                        Button("Open Entrance Doors") {
                            appModel.elevatorRideState = .openEntranceDoorsNotEntered
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            

            Button("Closing Entrance Doors") {
                appModel.elevatorRideState = .closingEntranceDoors
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            

            Button("Elevator Start") {
                appModel.elevatorRideState = .elevatorStart
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Introduction") {
                appModel.elevatorRideState = .introduction
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Elevator Universe") {
                appModel.elevatorRideState = .elevatorUniverseLoad
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Introduction Animation") {
                appModel.elevatorRideState = .introductionAnimation
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Closing Introduction Animation") {
                appModel.elevatorRideState = .closingIntroductionAnimation
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Universe Interaction") {
                appModel.elevatorRideState = .universeInteraction
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Closing Universe Interaction") {
                appModel.elevatorRideState = .closingUniverseInteraction
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Spawn ResearchLab") {
                appModel.elevatorRideState = .spawnResearchLab
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Elevator Stop") {
                appModel.elevatorRideState = .elevatorStop
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Open Exit Doors") {
                appModel.elevatorRideState = .openExitDoors
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
            
            Button("Dismiss ResearchLab") {
                appModel.elevatorRideState = .dismissResearchLab
                print("State: \(appModel.elevatorRideState)")
            }
            .disabled(appModel.elevatorRideState == .inTransition)
        }
      
        
    }
    
}

#Preview {
    AdminPanelView()
}
