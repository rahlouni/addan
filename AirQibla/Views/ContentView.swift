import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "location.north.circle")
                .font(.system(size: 64))
                .foregroundStyle(.teal)
                .accessibilityHidden(true)

            Text("Air Qibla")
                .font(.largeTitle.bold())

            Text("Faith Travels With You")
                .font(.title3)

            Text("Your offline travel companion for Qibla and prayer times.")
                .foregroundStyle(.secondary)
                .padding(.top)

            Text("Setup complete. Location, compass, and prayer services will be added in upcoming phases.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
