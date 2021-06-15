import Foundation
import OSLog
import os.signpost

@available(iOS 12.0, *)
extension OSLog {
    public static var subsystem = "com.roblabs.log-mapview"
    public static var category = "OSLog.MapView"
    public static var name: StaticString = "Log MapView"

    private static var oslog = OSLog(subsystem: subsystem, category: category)

    public enum mapEvents: String, CustomStringConvertible {
        public var description: String {
            return self.rawValue
        }

        case WillStartRenderingMap = "🦮1. WillStartRenderingMap"
        case DidFinishLoadingStyle = "🦮2. DidFinishLoadingStyle"
        case DidFinishRenderingMap = "🦮3. DidFinishRenderingMap"
        case DidFinishLoadingMap   = "🦮4. DidFinishLoadingMap"
        case DidBecomeIdle         = "🦮5. DidBecomeIdle"
        case WillStartRenderingMap_to_DidBecomeIdle = "🦮11. WillStartRendering has finished, now set timer to DidBecomeIdle"
        case RegionIsChanging      = "🦮100. RegionIsChanging"
        case WillStartLoadingMap   = "🦮100. WillStartLoadingMap"
    }

    public enum ID : os_signpost_id_t {
        case red = 0xff0000
        case green = 0x00ff00
        case blue = 0x0000ff
        case cyan = 0x00ffff
        case magenta = 0xff00ff
        case yellow = 0xffff00
    }

    public static func mapView(_ type: OSSignpostType,
                               _ message: String = "📍",
                               function: String = #function,
                               line: Int = #line) {

        #if DEBUG
        // Log to Xcode
        if(type == .event) {
            NSLog("[\(OSLog.subsystem)] \(message), \(function), line: \(line)")
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
