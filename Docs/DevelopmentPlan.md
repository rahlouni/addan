# Development plan

Implement one phase at a time and stop for review after each phase.

1. Native SwiftUI project and welcome screen.
2. Theme and clearly labeled static preview dashboard, using the supplied design reference when available.
3. CoreLocation and heading services; honest live, weak, stale, and denied states.
4. Great-circle Qibla bearing, smooth direction, accuracy gating, alignment hysteresis, and one haptic on entry.
5. Offline prayer engine using Adhan Swift after verifying its current package/API; methods and Asr settings.
6. Time-zone provenance, local time, and foreground travel dashboard.
7. Unit tests, accessibility, and error states.
8. Physical iPhone validation and TestFlight preparation.

## Product constraints

- iPhone, iOS 17+, SwiftUI, no backend, analytics, advertising, or account.
- Preserve last valid GPS fix and timestamp. Never fabricate location or heading, or label cached coordinates live.
- Qibla destination: 21.4225° N, 39.8262° E. True heading requires valid accuracy.
- Internal prayer timestamps use absolute `Date` values. Recalculate for location and date changes.
- Main dashboard says “Local Time” without a UTC suffix. Clearly identify device, saved, estimated, or verified time-zone provenance.
- No background location permission for MVP. GPS reception may be unavailable inside aircraft.
- Standard prayer calculations for MVP; flight-altitude corrections require separate astronomical validation and must not be advertised as implemented.
- Future tests cover bearings, angle normalization, alignment thresholds, stale/invalid fixes, midnight and time-zone boundaries, heading quality, altitude conversion, and prayer settings.

## Phase 1 validation

Full Xcode and the iOS SDK were unavailable during project creation. Project file syntax and source parsing can be checked with command-line tools, but these do not establish that an iOS build or simulator run succeeds. Perform the README build/run steps once Xcode is installed.
