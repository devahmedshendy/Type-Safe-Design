enum MicrophoneCapabilities: String, Identifiable {
    var id: String { rawValue }
    
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

//struct Microphone: Identifiable {
//    let id: Int
//    let isMuted: Bool
//    let volume: Double
//    let minVolume: Double
//    let maxVolume: Double
//
//    let capabilities: [any DeviceCapability]
//}

//extension Microphone {
//    init(from dto: MicrophoneDTO) {
//        self.id = dto.id
//        self.isMuted = dto.isMuted
//        self.volume = dto.volume
//        self.minVolume = dto.minVolume
//        self.maxVolume = dto.maxVolume
//
//        self.capabilities = dto.capabilities.map {
//            return switch $0 {
//            case .mute: MuteCapability()
//            case .volumeChange: VolumeChangeCapability()
//            }
//        }
//    }
//}

//protocol MicrophoneCapability {}
//
//struct MuteCapability: MicrophoneCapability {
//    let call: () -> MicrophoneCapability
//}
//
//struct UnmuteCapability: MicrophoneCapability {
//    let call: () -> MicrophoneCapability
//}
//
//struct VolumeUpCapability: MicrophoneCapability {
//    let call: (step: Int) -> Void
//}
