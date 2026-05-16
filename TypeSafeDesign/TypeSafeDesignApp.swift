import SwiftUI

@main
struct TypeSafeDesignApp: App {
    var body: some Scene {
        WindowGroup {
            MicrophoneListView(
                viewModel: MicrophoneViewModel(
                    service: MicrophoneServiceFake()
                )
            )
        }
    }
}
