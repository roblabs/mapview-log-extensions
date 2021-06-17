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

## Filter Logs 🦮

If you use the opinionated log strings, such as `OSLog.mapEvents.DidFinishLoadingMap`, then you filter the Instruments data by using the filter `mapview`.  Through empirical testing, for Mapbox flavored SDKs the log analysis shows that map view events occur in this order, with `DidFinishLoadingMap` likely the event of when the map is displayed for the user.

```console
00:00.286.828	[com.roblabs.log-mapview] Coordinator init, init(_:), line: 54
00:00.288.457	[com.roblabs.log-mapview] 🦮100. WillStartLoadingMap, mapViewWillStartLoadingMap(_:), line: 59
00:00.292.670	[com.roblabs.log-mapview] 🦮1. WillStartRenderingMap, mapViewWillStartRenderingMap(_:), line: 63
00:00.321.970	[com.roblabs.log-mapview] 🦮2. DidFinishLoadingStyle, mapView(_:didFinishLoading:), line: 67
00:00.531.795	[com.roblabs.log-mapview] 🦮3. DidFinishRenderingMap, mapViewDidFinishRenderingMap(_:fullyRendered:), line: 71
00:00.531.982	[com.roblabs.log-mapview] 🦮4. DidFinishLoadingMap, mapViewDidFinishLoadingMap(_:), line: 75
00:01.129.784	[com.roblabs.log-mapview] 🦮5. DidBecomeIdle, mapViewDidBecomeIdle(_:), line: 79
```
---

## Results 📈

Sample data from five runs of [Geography Class](https://github.com/roblabs/openmaptiles-ios-demo) on a Simulator.  This sample project is making use of the `OSLog` extensions for map views.

| Event `DidFinishLoadingMap` (msec)
| :-------------
| 531
| 499
| 500
| 529
| 514
| **mean = 514**

### Log vs. Signpost

*Logging template with `os_log` and set input filter by a string.*
> Making observations on the data, the first entry is for 381 milliseconds, and the first entry for `DidBecomeIdle` is at 1258 milliseconds.  The event `DidFinishLoadingMap` was at 651 milliseconds.  Screen recording of the simulator or device can be useful to show when the map is shown to the customer.
![Logging template with `os_log` and set input filter by a string.](os_log-Geography-Class.png)

---

*Logging template with `os_signpost` and input filter set to filter by the name of the subsystem.*
> This view of the `os_signpost` shows that the first entry for `DidBecomeIdle` is at 1258 milliseconds  The event `WillStartLoadingMap` started at 401 milliseconds, or about 850 milliseconds.  There is also a second `DidBecomeIdle` event occuring several seconds later.
![Logging template with `os_signpost` and input filter set to filter by the name of the subsystem.](os_signpost-Geography-Class.png)
