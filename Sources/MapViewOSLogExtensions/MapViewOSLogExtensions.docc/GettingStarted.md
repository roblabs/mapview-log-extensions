# Getting started with OSLog MapView Extensions

Opinionated Swift logging of `mapView` events for MapKit, Mapbox & MapLibre.

## How To

#### 1.  Add the package via the Swift Package Manager.

![Add the package via the Swift Package Manager.](Swift-Packages.png)


#### 2.  Add Opinionated Logs for map view.

See the enumeration ``mapEvents`` for suggested strings for your logs.

```swift
import OSLog
import MapViewOSLogExtensions

func beginMeasurementInterval() {
  // Construct the map view object
  OSLog.mapView(.begin, "measure some event")
}

func setZoomLevel(_ zoomLevel: Double) {
    // Logs to Xcode console & Xcode Instruments
    OSLog.mapView(.event, "zoomLevel: \(zoomLevel)")
    mapView.zoomLevel = zoomLevel
}

func endMeasurementInterval() {
  // This could be in an event handlers
  OSLog.mapView(.end, "measure some event")
}
```

---

## Xcode Instruments

Use Xcode Instruments for filtering logs and measuring event intervals.  For more information on Xcode Instruments & signposts, see [Measuring Performance Using Logging](https://developer.apple.com/videos/play/wwdc2018/405/) from WWDC 2018.

*Instruments with the Logging template selected.*

![Instruments with the Logging template selected.](Instruments-Logging.png)

---

## Results

*Logging template with `os_log` and set input filter by a string.*
> Making observations on the data, the first entry is for 381 milliseconds, and the first entry for `DidBecomeIdle` is at 1258 milliseconds.
![Logging template with `os_log` and set input filter by a string.](os_log-Geography-Class.png)

---

*Logging template with `os_signpost` and input filter set to filter by the name of the subsystem.*
> This view of the `os_signpost` shows that the first entry for `DidBecomeIdle` is at 1258 milliseconds.  The event `WillStartLoadingMap` started at 401 milliseconds, or about 850 milliseconds.  There is also a second `DidBecomeIdle` event occuring several seconds later.
![Logging template with `os_signpost` and input filter set to filter by the name of the subsystem.](os_signpost-Geography-Class.png)
