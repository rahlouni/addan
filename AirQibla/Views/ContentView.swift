import SwiftUI

private enum AppTab: String, CaseIterable {
    case qibla = "Qibla", prayers = "Prayers", travel = "Travel", more = "More"
    var symbol: String {
        switch self {
        case .qibla: return "location.north.circle"
        case .prayers: return "sun.horizon"
        case .travel: return "airplane"
        case .more: return "square.grid.2x2"
        }
    }
}

struct ContentView: View {
    @State private var selection: AppTab = .qibla
    @State private var showUTC = false

    var body: some View {
        ZStack {
            AirTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    header
                    previewBanner
                    switch selection {
                    case .qibla: qiblaDashboard
                    case .prayers: prayerScreen
                    case .travel: travelScreen
                    case .more: moreScreen
                    }
                }.padding(.horizontal, 22).padding(.top, 16).padding(.bottom, 28)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .safeAreaInset(edge: .bottom, spacing: 0) { tabBar }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                (Text("Air ").foregroundColor(AirTheme.teal) + Text("Qibla").foregroundColor(.white))
                    .font(.system(.largeTitle, design: .serif).weight(.medium))
                Text("Faith Travels With You").font(.caption).tracking(1.2).foregroundStyle(AirTheme.muted)
            }
            Spacer()
            Button { selection = .more } label: {
                Image(systemName: "gearshape").font(.title2).foregroundStyle(.white).padding(12)
            }.accessibilityLabel("Open preferences")
        }
    }

    private var previewBanner: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "eye").foregroundStyle(AirTheme.teal)
            VStack(alignment: .leading, spacing: 4) {
                Text("DESIGN PREVIEW").font(.caption.weight(.bold)).tracking(1.5).foregroundStyle(AirTheme.teal)
                Text("Sample readings · GPS and heading are not connected.")
                    .font(.caption).foregroundStyle(AirTheme.muted)
            }
            Spacer(minLength: 0)
        }.padding(16).background(AirTheme.teal.opacity(0.07), in: RoundedRectangle(cornerRadius: 18))
    }

    private var qiblaDashboard: some View {
        VStack(spacing: 20) {
            AirCard {
                HStack(spacing: 16) {
                    Image(systemName: "airplane").font(.title).foregroundStyle(AirTheme.teal)
                        .padding(16).background(AirTheme.teal.opacity(0.12), in: Circle())
                    VStack(alignment: .leading, spacing: 5) {
                        Text("In Flight").font(.system(.title2, design: .serif))
                        Text("Traveler Mode · Preview").font(.subheadline)
                        Text("Different skies. Same direction.").font(.caption).foregroundStyle(AirTheme.muted)
                    }
                }
            }
            VStack(spacing: 4) {
                QiblaCompass()
                Text("Sample direction · heading unavailable").font(.caption2).foregroundStyle(AirTheme.muted)
            }
            AirCard {
                VStack(spacing: 6) {
                    HStack(spacing: 14) {
                        dashboardIcon("location.fill")
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Current Location · Sample").font(.caption).foregroundStyle(AirTheme.muted)
                            Text("41.1832° N, 32.8821° W").font(.system(.title3, design: .serif))
                        }
                    }
                    Divider().padding(.vertical, 8)
                    HStack(spacing: 14) {
                        dashboardIcon("clock")
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Local Time").font(.caption).foregroundStyle(AirTheme.muted)
                            Text("12:18 PM").font(.system(.title2, design: .serif))
                        }
                        Spacer()
                    }
                    Text("Sample time zone · not verified against your location")
                        .font(.caption2).foregroundStyle(AirTheme.muted).padding(.top, 8)
                }
            }
            prayerSummary
            AirCard {
                HStack(spacing: 14) {
                    dashboardIcon("mountain.2.fill")
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Altitude · Sample").font(.caption).foregroundStyle(AirTheme.muted)
                        Text("36,420 ft").font(.system(.title, design: .serif)).monospacedDigit()
                    }
                    Spacer()
                }
            }
        }
    }

    private func dashboardIcon(_ name: String) -> some View {
        Image(systemName: name).font(.title2).foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(AirTheme.teal.opacity(0.11), in: RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AirTheme.teal.opacity(0.15)))
            .accessibilityHidden(true)
    }

    private var prayerSummary: some View {
        AirCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Label("CURRENT PRAYER", systemImage: "sun.max").font(.caption2.weight(.semibold)).tracking(1)
                        .foregroundStyle(AirTheme.gold)
                    Spacer()
                    Text("SAMPLE").font(.caption2).foregroundStyle(AirTheme.muted)
                }
                Text("Dhuhr").font(.system(.title, design: .serif))
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Next · Asr").font(.subheadline)
                        Text("3:42 PM").font(.caption).foregroundStyle(AirTheme.muted)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("03:24:00").font(.system(.title2, design: .rounded)).monospacedDigit().foregroundStyle(AirTheme.teal)
                        Text("Sample countdown").font(.caption2).foregroundStyle(AirTheme.muted)
                    }
                }
            }
        }
    }

    private var prayerScreen: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionTitle("A rhythm for your journey", subtitle: "Sample daily schedule · New York")
            prayerSummary
            AirCard {
                VStack(spacing: 14) {
                    ForEach(Array(zip(["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"], ["5:21 AM", "6:43 AM", "12:10 PM", "3:42 PM", "5:36 PM", "6:58 PM"])), id: \.0) { name, time in
                        InfoRow(title: name, value: time)
                    }
                }
            }
            note("Prayer calculations and method settings arrive in Phase 5. These times are illustrative and should not be used for worship.")
        }
    }

    private var travelScreen: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionTitle("Faith above the clouds", subtitle: "Your journey, at a glance")
            AirCard {
                VStack(alignment: .leading, spacing: 14) {
                    Label("Sensors not connected", systemImage: "antenna.radiowaves.left.and.right.slash").foregroundStyle(AirTheme.gold)
                    InfoRow(title: "GPS signal", value: "Unavailable in preview")
                    InfoRow(title: "Last GPS update", value: "No recorded fix")
                    InfoRow(title: "Coordinates", value: "—")
                    InfoRow(title: "Altitude", value: "— ft")
                    InfoRow(title: "Ground speed", value: "—")
                    InfoRow(title: "Qibla bearing", value: "—")
                    InfoRow(title: "Current / next prayer", value: "—")
                }
            }
            note("When connected, Travel will preserve your last valid GPS position and show its age if reception disappears. GPS may be unavailable inside an aircraft.")
            note("Flight-altitude prayer corrections are not implemented. The MVP will use standard ground-level calculations.")
        }
    }

    private var moreScreen: some View {
        VStack(alignment: .leading, spacing: 20) {
            sectionTitle("Make room for what matters", subtitle: "Preferences & information")
            AirCard {
                VStack(alignment: .leading, spacing: 12) {
                    Label("Travel time", systemImage: "clock").foregroundStyle(AirTheme.gold)
                    Toggle("Show device time in UTC", isOn: $showUTC).tint(AirTheme.teal)
                    TimelineView(.periodic(from: .now, by: 1)) { context in
                        Text(deviceTime(context.date)).monospacedDigit().foregroundStyle(AirTheme.teal)
                    }
                    Text(showUTC ? "UTC · device clock" : "Device time zone · not verified against your location")
                        .font(.caption).foregroundStyle(AirTheme.muted)
                }
            }
            AirCard {
                VStack(spacing: 12) {
                    InfoRow(title: "Altitude units", value: "Feet")
                    InfoRow(title: "Language", value: "English")
                    InfoRow(title: "Calculation method", value: "Not configured")
                    InfoRow(title: "Asr madhab", value: "Not configured")
                }
            }
            note("Built for privacy: this version has no accounts, analytics, advertising, or network requests. Location permission will be introduced with the GPS service.")
            Text("AIR QIBLA · FAITH TRAVELS WITH YOU").font(.caption2).tracking(1.3).foregroundStyle(AirTheme.gold).padding(.top, 12)
        }
    }

    private func deviceTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.timeZone = showUTC ? TimeZone(secondsFromGMT: 0) : .current
        return formatter.string(from: date)
    }

    private func sectionTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.system(.title2, design: .serif))
            Text(subtitle).font(.subheadline).foregroundStyle(AirTheme.muted)
        }
    }

    private func note(_ text: String) -> some View {
        Text(text).font(.footnote).foregroundStyle(AirTheme.muted).lineSpacing(5)
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button { selection = tab } label: {
                    VStack(spacing: 7) {
                        Image(systemName: tab.symbol).font(.system(size: 21))
                        Text(tab.rawValue).font(.caption2.weight(.medium))
                    }.frame(maxWidth: .infinity).frame(minHeight: 62)
                        .foregroundStyle(selection == tab ? AirTheme.teal : AirTheme.muted)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selection == tab ? .isSelected : [])
            }
        }.padding(.horizontal, 12).padding(.top, 8)
            .background(AirTheme.background.opacity(0.98))
            .overlay(alignment: .top) { Rectangle().fill(.white.opacity(0.08)).frame(height: 1) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
