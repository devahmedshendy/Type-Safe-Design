enum MicrophoneCapabilities {
    case mute
    case volumeChange
}

struct Microphone {
    typealias ID = Int
    
    let id: ID
    let capabilities: [MicrophoneCapabilities]
    let isMuted: Bool
    let volume: Double
    // step for the volume
    let minVolume: Double
    let maxVolume: Double
}

protocol MicrophoneCapability {}

struct MuteCapability: MicrophoneCapability {
    let call: () -> MicrophoneCapability
}

struct UnmuteCapability: MicrophoneCapability {
    let call: () -> MicrophoneCapability
}

struct VolumeUpCapability: MicrophoneCapability {
    let call: (step: Int) -> Void
}
