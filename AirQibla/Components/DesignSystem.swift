import SwiftUI

enum AirTheme {
    static let background = Color(red: 0.025, green: 0.09, blue: 0.075)
    static let teal = Color(red: 0.29, green: 0.87, blue: 0.75)
    static let gold = Color(red: 0.85, green: 0.70, blue: 0.40)
    static let muted = Color(red: 0.64, green: 0.75, blue: 0.71)
}

struct AirCard<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        content.padding(20).frame(maxWidth: .infinity, alignment: .leading)
            .background(AirTheme.teal.opacity(0.025), in: RoundedRectangle(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(AirTheme.teal.opacity(0.20)))
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title).foregroundStyle(AirTheme.muted)
            Spacer(minLength: 16)
            Text(value).multilineTextAlignment(.trailing).monospacedDigit()
        }.font(.subheadline).padding(.vertical, 5)
    }
}

struct KaabaIllustration: View {
    var body: some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: 12, y: 28)); p.addLine(to: CGPoint(x: 58, y: 12))
                p.addLine(to: CGPoint(x: 94, y: 31)); p.addLine(to: CGPoint(x: 94, y: 87))
                p.addLine(to: CGPoint(x: 48, y: 104)); p.addLine(to: CGPoint(x: 12, y: 85)); p.closeSubpath()
            }.fill(Color(red: 0.07, green: 0.10, blue: 0.10))
            Path { p in
                p.move(to: CGPoint(x: 12, y: 28)); p.addLine(to: CGPoint(x: 48, y: 47))
                p.addLine(to: CGPoint(x: 94, y: 31)); p.addLine(to: CGPoint(x: 58, y: 12)); p.closeSubpath()
            }.fill(Color(red: 0.20, green: 0.24, blue: 0.22))
            Path { p in
                p.move(to: CGPoint(x: 12, y: 43)); p.addLine(to: CGPoint(x: 48, y: 62))
                p.addLine(to: CGPoint(x: 94, y: 46))
            }.stroke(AirTheme.gold, lineWidth: 7)
            Path { p in
                p.move(to: CGPoint(x: 48, y: 48)); p.addLine(to: CGPoint(x: 48, y: 104))
            }.stroke(.white.opacity(0.15), lineWidth: 1)
            Rectangle().fill(AirTheme.gold).frame(width: 12, height: 23).offset(x: 17, y: 21)
        }.frame(width: 108, height: 112).accessibilityHidden(true)
    }
}

struct QiblaCompass: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var animate = false
    var body: some View {
        ZStack {
            Circle().fill(RadialGradient(colors: [AirTheme.teal.opacity(0.10), .clear], center: .center, startRadius: 35, endRadius: 155))
            Circle().stroke(AirTheme.teal.opacity(0.15), lineWidth: 1).padding(4)
            Circle().stroke(LinearGradient(colors: [AirTheme.gold, Color.white.opacity(0.9), AirTheme.gold, AirTheme.gold.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3).padding(9)
            Circle().stroke(AirTheme.teal.opacity(0.30), lineWidth: 1).padding(2)
            ForEach(0..<60) { index in
                Rectangle().fill(index % 5 == 0 ? Color.white.opacity(0.9) : AirTheme.teal.opacity(0.8))
                    .frame(width: index % 5 == 0 ? 2 : 1, height: index % 5 == 0 ? 12 : 5)
                    .offset(y: -133).rotationEffect(.degrees(Double(index) * 6))
            }
            Text("N").foregroundStyle(AirTheme.gold).offset(y: -105)
            Text("E").offset(x: 105)
            Text("S").offset(y: 105)
            Text("W").offset(x: -105)
            Circle().stroke(AirTheme.teal.opacity(0.18), style: StrokeStyle(lineWidth: 1, dash: [2, 7])).padding(65)
            KaabaIllustration().scaleEffect(0.70).offset(y: -32)
            VStack(spacing: 2) {
                Text("Qibla").font(.system(.title3, design: .serif))
                Text("63°").font(.system(size: 44, weight: .regular, design: .serif))
            }.foregroundStyle(.white).offset(y: 55)
            Image(systemName: "location.north.fill").font(.system(size: 42))
                .foregroundStyle(AirTheme.teal).rotationEffect(.degrees(45)).offset(x: 72, y: -74)
                .opacity(animate ? 1 : 0.5)
        }
        .font(.system(size: 13, weight: .semibold, design: .rounded))
        .foregroundStyle(AirTheme.muted)
        .frame(width: 300, height: 310)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) { animate = true }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Preview compass illustration. Not connected to device heading.")
    }
}
