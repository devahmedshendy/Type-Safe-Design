//
//  MuteCapabilityView.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI

struct MuteCapabilityView: View {
    @StateObject private var viewModel: MuteCapabilityViewModel

    init(store: MicrophoneStore) {
        self._viewModel = StateObject(
            wrappedValue: MuteCapabilityViewModel(store: store)
        )
    }

    var body: some View {
        Button {
            Task { await viewModel.mute() }
        } label: {
            Label(
                viewModel.isMuted ? "Unmute" : "Mute",
                systemImage: viewModel.isMuted ? "mic.slash" : "mic"
            )
        }
        .buttonStyle(.bordered)
        .tint(viewModel.isMuted ? .orange : .primary)
        .onChange(of: viewModel.isMuted) { oldValue, newValue in
            print("Microphone is now \(newValue ? "muted" : "unmuted")")
        }
    }
}
