final class MicrophoneServiceFake: MicrophoneService {
    
    private struct Defaults {
        let capabilities: [MicrophoneCapabilities]
        let minVolume: Double
        let maxVolume: Double
        let initialVolume: Double
    }
    
    private let defaults: [Int: Defaults] = [
        1: .init(capabilities: [.mute, .volumeChange], minVolume: 0,  maxVolume: 100, initialVolume: 50),
        2: .init(capabilities: [.mute], minVolume: 0,  maxVolume: 80,  initialVolume: 40),
        3: .init(capabilities: [.volumeChange], minVolume: 10, maxVolume: 90,  initialVolume: 60),
        4: .init(capabilities: [], minVolume: 0,  maxVolume: 0, initialVolume: 0)
    ]
    
    private var mutedIDs: Set<Int> = []
    private var volumes: [Int: Double] = [:]      
    
    func fetchMicrophones() async throws -> [Microphone] {
        try await Task.sleep(for: .seconds(1))
        return defaults
            .map { id, d in
                Microphone(
                    id: id,
                    capabilities: d.capabilities,
                    isMuted: mutedIDs.contains(id),
                    volume: volumes[id, default: d.initialVolume],
                    minVolume: d.minVolume,
                    maxVolume: d.maxVolume
                )
            }
            .sorted { $0.id < $1.id }
    }
    
    func muteMicrophone(id: Int) async throws {
        try await Task.sleep(for: .seconds(1))
        if mutedIDs.contains(id) {
            mutedIDs.remove(id)
        } else {
            mutedIDs.insert(id)
        }
    }
    
    func setVolume(id: Int, value: Double) async throws {
        try await Task.sleep(for: .seconds(1))
        volumes[id] = value
    }
}
