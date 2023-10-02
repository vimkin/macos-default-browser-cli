import CoreServices
import Foundation

enum URLScheme: String {
    case http
    case https
}

enum LaunchServices {
    static func setDefaultHandler(_ handler: String, for urlScheme: URLScheme) throws {
        guard LSSetDefaultHandlerForURLScheme(urlScheme.rawValue as CFString, handler as CFString) == noErr else {
            throw Error.couldNotSetDefaultBrowser
        }

        // INFO: MacOS shows a dialog for the user to confirm changing of the default browser.
        // If the user chooses not to change the default browser, we will not be informed about that
        // since `LSSetDefaultHandlerForURLScheme` is not blocking and returns immediately.
    }

    static func copyDefaultHandler(for urlScheme: URLScheme) -> String? {
        guard let handler = LSCopyDefaultHandlerForURLScheme(urlScheme.rawValue as CFString) else {
            return nil
        }

        return handler.takeRetainedValue() as String
    }

    static func copyAllHandlers(for urlScheme: URLScheme) -> [String]? {
        guard let handlers = LSCopyAllHandlersForURLScheme(urlScheme.rawValue as CFString) else {
            return nil
        }

        return handlers.takeRetainedValue() as? [String]
    }

    static func copyApplicationURL(for bundleId: BundleId) -> URL? {
        guard let urls = LSCopyApplicationURLsForBundleIdentifier(bundleId as CFString, nil) else {
            return nil
        }
        guard let bestMatch = (urls.takeRetainedValue() as! [URL]).first else {
            return nil
        }

        return bestMatch
    }
}

extension LaunchServices {
    enum Error: Swift.Error {
        case couldNotSetDefaultBrowser
    }
}
