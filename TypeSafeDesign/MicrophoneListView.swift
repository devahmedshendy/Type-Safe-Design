import SwiftUI
import Combine

struct MicrophoneListView: View {
    @State private var viewModel: MicrophoneViewModel

    init(viewModel: MicrophoneViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.microphones.isEmpty {
                    ContentUnavailableView(
                        "No Microphones",
                        systemImage: "mic.slash",
                        description: Text("No microphones were found.")
                    )
                } else {
                    List(viewModel.microphones, id: \.id) { microphone in
                        MicrophoneRowView(
                            microphone: microphone,
                            service: viewModel.service
                        )
                    }
                }
            }
            .navigationTitle("Microphones")
        }
        .task {
            await viewModel.loadMicrophones()
        }
    }
}


