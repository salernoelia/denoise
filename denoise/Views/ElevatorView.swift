//
//  ElevatorView.swift
//  denoise
//
//  Created by Elia Salerno on 16.10.2024.
//




import SwiftUI
import RealityKit
import RealityKitContent

struct ElevatorView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        RealityView { content in
            
            if let elevator = try? await Entity(named: "elevator.usda",
                                                            in: realityKitContentBundle) {
                content.add(elevator)
                
                print("added elevator")
            }
        }
    }
}
