import Foundation
import SwiftUI

@Observable
final class MicrophoneViewModel {
    private let volumeStep: Double = 10 // should be moved to the store, and used by the capability viewmodel
    private(set) var microphones: [Microphone] = []

    @ObservationIgnored
    let service: MicrophoneService

    init(service: MicrophoneService) {
        self.service = service
    }

    func loadMicrophones() async {
        do {
            microphones = try await service.fetchMicrophones()
//            microphones = result.map(Microphone.init(from:))

        } catch {
            print("Failed to fetch microphones:", error)
        }
    }

//    func mute(_ microphone: MicrophoneDTO) async {
//        guard microphone.capabilities.contains(.mute) else { return }
//        do {
//            try await service.muteMicrophone(id: microphone.id)
//            await loadMicrophones()
//        } catch {
//            print("Failed to mute microphone:", error)
//        }
//    }
//
//    func setVolume(_ microphone: MicrophoneDTO, value: Double) async {
//        guard microphone.capabilities.contains(.volumeChange) else { return }
//        let clamped = min(max(value, microphone.minVolume), microphone.maxVolume)
//        do {
//            try await service.setVolume(id: microphone.id, value: clamped)
//            await loadMicrophones()
//        } catch {
//            print("Failed to set volume:", error)
//        }
//    }
//
//    func stepVolumeUp(_ microphone: MicrophoneDTO) async {
//        await setVolume(microphone, value: microphone.volume + volumeStep)
//    }
//
//    func stepVolumeDown(_ microphone: MicrophoneDTO) async {
//        await setVolume(microphone, value: microphone.volume - volumeStep)
//    }
}
