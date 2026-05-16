protocol MicrophoneService {
    func fetchMicrophones() async throws -> [Microphone]
    func muteMicrophone(id: Int) async throws
    func setVolume(id: Int, value: Double) async throws
}
