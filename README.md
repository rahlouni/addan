# Air Qibla

**Faith Travels With You**

Native iPhone app for offline Qibla direction and prayer times. Repository: `rahlouni/addan`.

## Phase 2

SwiftUI dashboard targeting iOS 17+, with emerald, teal, and gold styling, a vector Kaaba compass illustration, and four navigable tabs. A persistent Design Preview banner identifies sample readings. GPS, heading, alignment, and prayer calculations are not connected. More includes a working device-clock UTC toggle. No external dependencies, network calls, accounts, or sensor permissions yet.

## Run

1. Install full Xcode from the Mac App Store, launch it, and finish its component installation (including an iOS Simulator runtime).
2. Open `AirQibla.xcodeproj` in Xcode.
3. Choose the `AirQibla` scheme and an installed iPhone simulator, then press Command-R.
4. Confirm the dashboard shows “Air Qibla” and the Design Preview banner. Tap all four tabs. In More, toggle device time to UTC. Rotate the simulator and try larger accessibility text to check layout.

For a physical iPhone, choose your development team in the target’s Signing & Capabilities settings and replace the placeholder bundle identifier `com.rahlouni.AirQibla` if needed. Connect and select your iPhone as the run destination.

VS Code can edit the source; use Xcode to build, sign, preview, and run the app.

With full Xcode selected as the active developer directory, a simulator build can also be run from Terminal:

```sh
xcodebuild -project AirQibla.xcodeproj -scheme AirQibla -sdk iphonesimulator -configuration Debug -derivedDataPath /tmp/AirQiblaDerivedData CODE_SIGNING_ALLOWED=NO build
```

## Structure

- `AirQibla/App`: app lifecycle.
- `AirQibla/Views`: SwiftUI presentation.
- `Docs/DevelopmentPlan.md`: phase boundaries and product constraints.

Additional modules and unit tests will be introduced with the features they support. App icons, sensor services, and prayer calculations remain for later phases.
