//
//  MicrophoneRowView.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI
import Combine

struct MicrophoneRowView: View {
    @StateObject private var store: MicrophoneStore

    init(microphone: Microphone, service: MicrophoneService) {
        self._store = StateObject(
            wrappedValue: .init(
                microphone: microphone,
                service: service
            )
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Microphone #\(store.microphone.id)")
                .font(.headline)

            if store.microphone.capabilities.isEmpty {
                Text("No capabilities")
                    .font(.caption)
                    .foregroundStyle(.secondary)

            } else {
                ForEach(store.microphone.capabilities) { capability in
                    CapabilityView(
                        store: store,
                        capability: capability
                    )
                }
            }
        }
        .padding(.vertical, 4)
    }
}
