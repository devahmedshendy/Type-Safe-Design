import SwiftUI

struct MicrophoneRowView: View {
    let microphone: Microphone
    let viewModel: MicrophoneViewModel

    @State private var sliderValue: Double = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Microphone #\(microphone.id)")
                .font(.headline)

            if microphone.capabilities.contains(.mute) {
                Button {
                    Task { await viewModel.mute(microphone) }
                } label: {
                    Label(
                        microphone.isMuted ? "Unmute" : "Mute",
                        systemImage: microphone.isMuted ? "mic.slash" : "mic"
                    )
                }
                .buttonStyle(.bordered)
                .tint(microphone.isMuted ? .orange : .primary)
            }

            if microphone.capabilities.contains(.volumeChange) {
                HStack {
                    Button {
                        Task { await viewModel.stepVolumeDown(microphone) }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(microphone.volume <= microphone.minVolume)

                    Slider(
                        value: $sliderValue,
                        in: microphone.minVolume...microphone.maxVolume,
                        onEditingChanged: { isEditing in
                            guard !isEditing else { return }
                            Task { await viewModel.setVolume(microphone, value: sliderValue) }
                        }
                    )

                    Button {
                        Task { await viewModel.stepVolumeUp(microphone) }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(microphone.volume >= microphone.maxVolume)
                }
            }

            if microphone.capabilities.isEmpty {
                Text("No capabilities")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
        .onAppear { sliderValue = microphone.volume }
        .onChange(of: microphone.volume) { _, new in sliderValue = new }
    }
}
