enum MicrophoneCapability {
    case mute
    case volumeChange
}

struct Microphone {
    let id: Int
    let capabilities: [MicrophoneCapability]
    let isMuted: Bool
    let volume: Double
    let minVolume: Double
    let maxVolume: Double
}
