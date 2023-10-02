import Foundation

public typealias BundleId = String

public struct DefaultBrowser: Equatable {
    public let bundleId: BundleId

    public var name: String {
        guard let name = bundleId.split(separator: ".").last else {
            return bundleId
        }

        return String(name)
    }

    public var url: URL? {
        guard let url = LaunchServices.copyApplicationURL(for: bundleId) else {
            return nil
        }

        return url
    }

    init(bundleId: String) {
        self.bundleId = bundleId.lowercased()
    }

    public func makeDefault() throws {
        try LaunchServices.setDefaultHandler(bundleId, for: .http)
        try LaunchServices.setDefaultHandler(bundleId, for: .https)
    }
}

public extension DefaultBrowser {
    static var all: [DefaultBrowser] {
        guard let bundleIds = LaunchServices.copyAllHandlers(for: .http) else {
            return []
        }

        return bundleIds.map { DefaultBrowser(bundleId: $0) }
    }

    static var current: DefaultBrowser? {
        guard let bundleId = LaunchServices.copyDefaultHandler(for: .http) else {
            return nil
        }

        return DefaultBrowser(bundleId: bundleId)
    }
}
