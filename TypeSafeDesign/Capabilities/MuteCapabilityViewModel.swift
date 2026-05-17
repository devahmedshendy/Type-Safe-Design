//
//  MuteCapabilityViewModel.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI
import Combine

@MainActor
final class MuteCapabilityViewModel: ObservableObject {
    @Published private(set) var isMuted: Bool

    private let store: MicrophoneStore
    private var cancellables = Set<AnyCancellable>()

    init(store: MicrophoneStore) {
        self.store = store
        self.isMuted = store.microphone.isMuted

        self.store.$microphone
            .map(\.isMuted)
            .receive(on: DispatchQueue.main)
            .assign(to: &$isMuted) // This solution is new to me
    }

    func mute() async {
        await store.mute(store.microphone)
    }
}
