//
//  ImmersiveView.swift
//  denoise
//
//  Created by Elia Salerno on 05.10.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent
import UmainSpatialGestures

struct ImmersiveView: View {
    @Environment(\.realityKitScene) var scene
    @Environment(AppModel.self) var appModel
    
    @State var exhibitionSceneEntity = Entity()
    @State var galaxyVisualization = Entity()
    
    @State var openDoorButtonEntity = Entity()
    @State var startElevatorButtonEntity = Entity()
    
    
    var body: some View {
        ZStack {
            RealityView { content, attachments in
                if let exhibitionScene = try? await Entity(named: "ExhibitionScene", in: realityKitContentBundle) {
                    exhibitionSceneEntity = exhibitionScene
                    content.add(exhibitionSceneEntity)
                    
                   
                    
                    
                    if let galaxyVisualizationQuery = exhibitionScene.findEntity(
                        named: "galaxy_rotation"
                    ) {
                        galaxyVisualization = galaxyVisualizationQuery
                        if let labelAttachment = attachments.entity(for: "GalaxyLabel") {
                            labelAttachment.position = [0, 0.5, 0]
                            galaxyVisualization.addChild(labelAttachment)
                        }
                    }
                    
                    if let buttonOpenDoorCube = exhibitionScene.findEntity(
                        named: "buttonOpenDoorCube"
                    ) {
                        if let labelAttachment = attachments.entity(for: "buttonOpenDoor") {
                            labelAttachment.position = [0, 0.5, 0]
                            buttonOpenDoorCube.addChild(labelAttachment)
                        }
                    }
                    
                    if let buttonStartElevatorCube = exhibitionScene.findEntity(
                        named: "buttonStartElevatorCube"
                    ) {
                        if let labelAttachment = attachments.entity(for: "buttonStartElevator") {
                            labelAttachment.position = [0, 0.5, 0]
                            buttonStartElevatorCube.addChild(labelAttachment)
                        }
                    }
                    
                    if let buttonOpenDoorQuery = exhibitionScene.findEntity(
                        named: "buttonOpenDoor"
                    ) {
                        openDoorButtonEntity = buttonOpenDoorQuery
                    }
                    
                    if let buttonStartElevator = exhibitionScene.findEntity(
                        named: "buttonStartElevator"
                    ) {
                        startElevatorButtonEntity = buttonStartElevator
                    }
                    
                    startTimeline(name: "sceneSetup")
                }
            }  attachments: {
                Attachment(id: "GalaxyLabel") {
                    Text("Black Hole")
                        .font(.extraLargeTitle)
                        .padding()
                        .glassBackgroundEffect()
                }
                Attachment(id: "buttonOpenDoor") {
                    Text("Open the Doors")
                        .font(.extraLargeTitle)
                        .padding()
                        .glassBackgroundEffect()
                }
                
                Attachment(id: "buttonStartElevator") {
                    Text("Start the Elevator")
                        .font(.extraLargeTitle)
                        .padding()
                        .glassBackgroundEffect()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RealityKit.NotificationTrigger"))) { notification in
                      handleNotification(notification)
            }
            .onChange(of: appModel.elevatorRideState) {
                if appModel.elevatorRideState == .openEntranceDoorsNotEntered {
                    startTimeline(name: "openHoistDoors")
                }
                /*
                 
                 if appModel.elevatorRideState == .closedEntranceDoors {
                 startTimeline(name: "closeHoistDoors")
                 }
                 
                 if appModel.elevatorRideState == .elevatorUniverseLoad {
                 startTimeline(name: "startGalaxy")
                 }
                 
                 if appModel.elevatorRideState == .introduction {
                 startTimeline(name: "startMatterReflection")
                 startTimeline(name: "startMatterPasstrough")
                 }*/
                /*
                if appModel.elevatorRideState == .elevatorStart {
                    startTimeline(name: "startElevator")
                    print("startElevator")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
                        startTimeline(name: "startGalaxyOrbit")
                    }
                    
                }*/
            }.gesture(TapGesture().targetedToEntity(
                openDoorButtonEntity
            ).onEnded({ _ in
                startTimeline(name: "openHoistDoors")
                print("opening door")
            }))
            .gesture(TapGesture().targetedToEntity(
                startElevatorButtonEntity
            ).onEnded({ _ in
                startTimeline(name: "startElevator")
                print("starting elevator")
                DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
                    startTimeline(name: "startGalaxyOrbit")
                }
            }))
            
            
            
        }
        
        
    }
    
    
    private func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let _ = userInfo["RealityKit.NotificationTrigger.Scene"] as? RealityKit.Scene,
              let identifier = userInfo["RealityKit.NotificationTrigger.Identifier"] as? String else {
            return
        }
        
        print("Recieved Notification: \(identifier)")
        
        if identifier == "sceneSetup" {
            print("Scene has been setup")
            
            if let skySphereEntity = exhibitionSceneEntity.findEntity(named: "SkySphere") {
                print("SkySphere found.")
            } else {
                print("SkySphere not found")
            }
        } else {
            print("Unhandled identifier: \(identifier)")
        }
    }

    
    private func startTimeline(name: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("RealityKit.NotificationTrigger"),
            object: nil,
            userInfo: [
                "RealityKit.NotificationTrigger.Scene": scene!,
                "RealityKit.NotificationTrigger.Identifier": "\(name)"
            ]
        )
        
    }
    
}
