// Copyright ePi Rational, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT
import Foundation
import OSLog
import os.signpost

@available(iOS 12.0, *)
extension OSLog {
    public static var subsystemMapview = "com.roblabs.log-mapview"
    public static var categoryMapview = "OSLog.MapView"
    public static var name: StaticString = "Log MapView"

    private static var oslog = OSLog(subsystem: subsystemMapview, category: categoryMapview)

    public enum mapEvents: String, CustomStringConvertible {
        public var description: String {
            return self.rawValue
        }

        /// Convenience string for the event:  map view is about to start rendering some of its tiles.
        case WillStartRenderingMap = "🦮1. WillStartRenderingMap"
        
        /// Convenience string for the event:  map has just finished loading a style.
        case DidFinishLoadingStyle = "🦮2. DidFinishLoadingStyle"
        
        /// Convenience string for the event:  map view has finished rendering all visible tiles.
        case DidFinishRenderingMap = "🦮3. DidFinishRenderingMap"
        
        /// Convenience string for the event:  map view has finished loading.
        case DidFinishLoadingMap   = "🦮4. DidFinishLoadingMap"
        
        /// Convenience string for the event:  all currently requested tiles have loaded.
        case DidBecomeIdle         = "🦮5. DidBecomeIdle"
        
        /// Convenience string for the event:  interval from `WillStartRendering` to `DidBecomeIdle`.
        case WillStartRenderingMap_to_DidBecomeIdle = "🦮11. WillStartRendering has finished, now set timer to DidBecomeIdle"
        
        /// Convenience string for the event:  viewpoint depicted by the map view is changing.
        case RegionIsChanging      = "🦮100. RegionIsChanging"
        
        /// Convenience string for the event:  map view will begin to load.
        case WillStartLoadingMap   = "🦮100. WillStartLoadingMap"
    }

    /// A convenience values for signpost intervals that will never occur concurrently.
    public enum ID : os_signpost_id_t {
        case red = 0xff0000
        case green = 0x00ff00
        case blue = 0x0000ff
        case cyan = 0x00ffff
        case magenta = 0xff00ff
        case yellow = 0xffff00
    }

    ///  Log a map view event.
    ///
    ///  An opinionated, convenience function for logging to both the Xcode console & the Logging template in Xcode Instruments.
    ///
    ///  ```swift
    ///  // Log an event
    ///  OSLog.mapView(.event, "Coordinator init")
    ///
    ///  // Begin & end a signpost
    ///  OSLog.mapView(.begin, "online map")
    ///  // Load map style, map data, render, and return to map idle state
    ///  OSLog.mapView(.end, "online map")
    ///  ```
    ///
    /// - Parameters:
    ///     - type: The signpost type
    ///     - message: the message as a string
    ///     - function: the calling function name
    ///     - line: the line number
    public static func mapView(_ type: OSSignpostType,
                               _ message: String = "📍",
                               function: String = #function,
                               line: Int = #line) {

        #if DEBUG
        // Log to Xcode
        if(type == .event) {
            NSLog("[\(OSLog.subsystemMapview)] \(message), \(function), line: \(line)")
        }
        #endif

        // Log to Xcode Instruments
        os_signpost(type,
                    log: OSLog.oslog,
                    name: name,
                    "%{public}s, %{public}s, line %{public}s",
                    message, "\(function)", "\(line)")
    }
}
