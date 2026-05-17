//
//  CapabilityView.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI
import Combine

struct CapabilityView: View {
    let store: MicrophoneStore
    let capability: MicrophoneCapabilities

    var body: some View {
        switch capability {
        case .mute:
            MuteCapabilityView(store: store)
        case .volumeChange:
            VolumeChangeCapabilityView(store: store)
        }
    }
}
