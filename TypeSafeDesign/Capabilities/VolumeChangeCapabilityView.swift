//
//  VolumeChangeCapabilityView.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI

struct VolumeChangeCapabilityView: View {
    @StateObject private var viewModel: VolumeChangeCapabilityViewModel
    @State private var localVolume: Double = 0.0

    init(store: MicrophoneStore) {
        self._viewModel = StateObject(wrappedValue: .init(store: store))
        self._localVolume = State(initialValue: store.microphone.volume)
    }

    var body: some View {
        HStack {
            Button {
                Task { await viewModel.stepDown() }
            } label: {
                Image(systemName: "minus")
            }
            .disabled(viewModel.volume <= viewModel.minVolume)

            Slider(
                value: $localVolume,
                in: viewModel.minVolume...viewModel.maxVolume,
                onEditingChanged: { isEditing in
                    guard !isEditing else { return }
                    Task { await viewModel.setVolume(localVolume) }
                }
            )

            Button {
                Task { await viewModel.stepUp() }
            } label: {
                Image(systemName: "plus")
            }
            .disabled(viewModel.volume >= viewModel.maxVolume)
        }
        .onChange(of: viewModel.volume) { oldValue, newValue in
            print("Volume changed from \(oldValue) to \(newValue)")
        }
    }
}
