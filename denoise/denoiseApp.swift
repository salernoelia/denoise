// denoiseApp.swift
// denoise
//
// Created by Elia Salerno on 03.10.2024.
//

import SwiftUI

@main
struct denoiseApp: App {
    @State private var appModel = AppModel()
    
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @StateObject private var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
                .task {
                    openWindow(id: "supportWindow")
                    await onAppStart()
                    
                }
                .environment(appModel)
                .padding()
        }
        .defaultSize(width: 600, height: 400)
        
        
        WindowGroup(id: "supportWindow") {
            SupportView()
                .environment(appModel)
                .padding()
        }
        .defaultSize(width: 400, height: 600)
        

        /*
         AdminPanelView()
         .environment(appModel)
         .task {
         await onAppStart()
         
         }
         .cornerRadius(10)*/
        
        /*  PostDataView()
         FetchDataView()*/
        
        ImmersiveSpace(id: appModel.elevatorRideID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.elevatorRideState = .closedEntranceDoors
                    print(appModel.elevatorRideState)
                }
        }
        .immersionStyle(
            selection: .constant(.full),
            in: .full
        )
        
    }
    
    
    
    private func onAppStart() async {
        print("VisionOS App has started!")
        await openImmersiveSpaceWithId(appModel.elevatorRideID)
    }
    
    public func openImmersiveSpaceWithId(_ id: String) async {
        await openImmersiveSpace(id: id)
    }
    
    public func dismissImmersiveSpace() async {
        await dismissImmersiveSpace()
    }
}

