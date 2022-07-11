// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
    public enum Alert {
        /// ok
        public static let ok = L10n.tr("Localizable", "alert.ok")
    }

    public enum Error {
        /// Error
        public static let common = L10n.tr("Localizable", "error.common")
        /// It seems something went wrong, please try again later.
        public static let somethingWrong = L10n.tr("Localizable", "error.something_wrong")
    }

    public enum Label {
        /// Created at
        public static let createdAt = L10n.tr("Localizable", "label.created_at")
        /// Director
        public static let director = L10n.tr("Localizable", "label.director")
        /// Edited at
        public static let editedAt = L10n.tr("Localizable", "label.edited_at")
        /// Episode
        public static let episode = L10n.tr("Localizable", "label.episode")
        /// NA
        public static let notAvailable = L10n.tr("Localizable", "label.not_available")
        /// Opening crawl
        public static let openingCrawl = L10n.tr("Localizable", "label.opening_crawl")
        /// Producer
        public static let producer = L10n.tr("Localizable", "label.producer")
        /// Release Date
        public static let releaseDate = L10n.tr("Localizable", "label.release_date")
    }

    public enum Navigation {
        public enum Title {
            /// Movies
            public static let movies = L10n.tr("Localizable", "navigation.title.movies")
        }
    }
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
