# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### TO DO
- Connection Panel State => Connection Status (green/red) => Setting double click on RobotA,B- Wrap Container to control freely
- study map widget style - as a free moveable layer not depend as home's widget.
- Global App state (Cache) to get back previous state on application startup 
- Toast Notification.
- DateTime ASync
- Notification 
- ribbonButton - state managements.

### Troubleshoot

```bash
flutter config --list
```

```bash
flutter config --enable-linux-desktop
```
#### Bundle MAP Canvaskit for releaseing app.
```bash
flutter build web --web-renderer canvaskit --release
```
#### Offline Issue

```
Error: TypeError: Failed to fetch dynamically imported module:
https://www.gstatic.com/flutter-canvaskit/18818009497c581ede5d8a3b8b833b81d00cebb7/chromium/canvaskit.js
```