//
//  VolumeChangeCapabilityViewModel.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI
import Combine

@MainActor
final class VolumeChangeCapabilityViewModel: ObservableObject {
    @Published private(set) var volume: Double
    @Published private(set) var minVolume: Double
    @Published private(set) var maxVolume: Double

    private let store: MicrophoneStore
    private var cancellables = Set<AnyCancellable>()

    init(store: MicrophoneStore) {
        self.store = store
        self.volume = store.microphone.volume
        self.minVolume = store.microphone.minVolume
        self.maxVolume = store.microphone.maxVolume

        store.$microphone
            .receive(on: DispatchQueue.main)
            .sink { [weak self] mic in
                self?.volume = mic.volume
                self?.minVolume = mic.minVolume
                self?.maxVolume = mic.maxVolume
            }
            .store(in: &cancellables)
    }

    func stepDown() async {
        let next = max(minVolume, volume - 10)
        await store.setVolume(self.store.microphone, value: next)
    }

    func stepUp() async {
        let next = min(maxVolume, volume + 10)
        await store.setVolume(self.store.microphone, value: next)
    }

    func setVolume(_ value: Double) async {
        await store.setVolume(self.store.microphone, value: value)
    }
}
