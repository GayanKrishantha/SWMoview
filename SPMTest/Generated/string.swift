// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// ok
    internal static let alertOk = L10n.tr("Localizable", "alert_ok")
    /// Error
    internal static let errorError = L10n.tr("Localizable", "error_error")
    /// Created at
    internal static let labelCreatedAt = L10n.tr("Localizable", "label_created_at")
    /// Director
    internal static let labelDirector = L10n.tr("Localizable", "label_director")
    /// Edited at
    internal static let labelEditedAt = L10n.tr("Localizable", "label_edited_at")
    /// Episode
    internal static let labelEpisode = L10n.tr("Localizable", "label_episode")
    /// Episode:
    internal static let labelEpisode = L10n.tr("Localizable", "label_episode:")
    /// N/A
    internal static let labelNotAvailable = L10n.tr("Localizable", "label_not_available")
    /// Opening crawl
    internal static let labelOpeningCrawl = L10n.tr("Localizable", "label_opening_crawl")
    /// Producer
    internal static let labelProducer = L10n.tr("Localizable", "label_producer")
    /// Release Date
    internal static let labelReleaseDate = L10n.tr("Localizable", "label_release_date")
    /// Movies
    internal static let navigationTitleMovies = L10n.tr("Localizable", "navigation_title_movies")
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
