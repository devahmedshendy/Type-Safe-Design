//
//  MicrophoneStore.swift
//  TypeSafeDesign
//
//  Created by Ahmed Shendy on 17/05/2026.
//

import SwiftUI
import Combine

@MainActor
final class MicrophoneStore: ObservableObject {
    @Published private(set) var microphone: Microphone
    private let service: MicrophoneService

    private let volumeStep: Double = 10

    init(microphone: Microphone, service: MicrophoneService) {
        self.microphone = microphone
        self.service = service
    }

    func mute(_ microphone: Microphone) async {
        do {
            try await service.muteMicrophone(id: microphone.id)
            self.microphone = Microphone(
                id: microphone.id,
                capabilities: microphone.capabilities,
                isMuted: microphone.isMuted ? false : true, // We can optimistically toggle the mute state without refetching from the service, since we know it will succeed. This is a common pattern in UI development to provide a more responsive experience.
                volume: microphone.volume,
                minVolume: microphone.minVolume,
                maxVolume: microphone.maxVolume
            )

//            await loadMicrophones() // I don't know why we need to refetch mute everytime
        } catch {
            print("Failed to mute microphone:", error) // We should probably show an error to the user instead of just printing it
        }
    }

    func setVolume(_ microphone: Microphone, value: Double) async {
        do {
            try await service.setVolume(id: microphone.id, value: value)
            self.microphone = Microphone(
                id: microphone.id,
                capabilities: microphone.capabilities,
                isMuted: microphone.isMuted,
                volume: value,
                minVolume: microphone.minVolume,
                maxVolume: microphone.maxVolume
            )

        } catch {
            print("Failed to set volume:", error)
        }
    }
}
