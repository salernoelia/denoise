//
//  ContentView.swift
//  denoise
//
//  Created by Elia Salerno on 16.10.2024.
//


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to denoise!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Image("elevator")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("“denoise” is a virtual exhibition, which allows you to use the elevator that brings you to the largest dark matter detector on the planet! Along the way, you will discover what we currently know about the mysterious dark matter.")
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
        }
        .padding()
    }
}


struct SupportView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Need help?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Image("handTapping")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Get a quick introduction on how all of this works by looking at this sign and tapping your fingers together.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                print("onboarding")
            }) {
                Text("Start Instruction")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .padding(.horizontal, 20)
    }
}

