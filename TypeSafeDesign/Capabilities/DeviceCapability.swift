//
//  DeviceCapability.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//


import SwiftUI
import Combine

protocol DeviceCapability {
    var type: MicrophoneCapabilities { get }

    associatedtype ContentView: View

    @ViewBuilder
    func makeView(store: MicrophoneStore) -> ContentView
}