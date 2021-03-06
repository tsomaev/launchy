//
//
//  Launchy
//  
//  Created on 27.02.2021
//  
//  

import Foundation

/**
 Detailed information about SpaceX rocket launch.
 */
struct Launch: Decodable, Equatable {

    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }

    /// Links to related articles, videos, images and other materials on the internet.
    struct LaunchLinks: Decodable {
        struct FlickrLinks: Decodable {
            let small: [URL]
            let original: [URL]
        }

        /// Flickr images archive.
        let flickr: FlickrLinks
        /// Official press kit.
        let presskit: URL?
        /// A link to launch webcast/recording.
        let webcast: URL?
        /// An article about the launch.
        let article: URL?
        /// Link to a dedicated Wikipedia page.
        let wikipedia: URL?
    }

    enum DatePrecision: String, Decodable {
        case half, quarter, year, month, day, hour
    }

    enum CodingKeys: String, CodingKey {
        case id, name, rocket, upcoming, details, links

        case number = "flight_number"
        case launchDate = "date_unix"
        case datePrecision = "date_precision"
    }

    /// Unique identifier of the launch.
    let id: String

    /// Flight number.
    let number: Int

    /// Launch name, e.g.: "FalconSat"
    let name: String

    /// Brief inromation regarding the launch.
    ///
    /// E.g. "Successful first stage burn and transition to second stage..."
    let details: String?

    /// Unique identifier of the rocket used.
    let rocket: String

    /// Launch date in UTC.
    let launchDate: Date

    /// A launch scheduled for 2022 July would be represented as 2022-07-01T00:00:00.000Z. In this case, current field would be set as `month`, meaning the date is only valid to the month level, or 2022-07
    let datePrecision: DatePrecision

    /// Is this an upcoming launch or not.
    let upcoming: Bool

    /// An object which (optionally) contains: YouTube video link, article link, large size launch images, Wikipedia article link and more.
    let links: LaunchLinks

}

extension Launch {

    /// Image of the launch.
    var largeImageURL: URL? { links.flickr.original.first }

    var largeImageURLs: [URL] { links.flickr.original }

}
