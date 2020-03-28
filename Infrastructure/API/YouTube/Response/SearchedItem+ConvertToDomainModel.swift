//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain

extension YouTube.SearchedItem {
    func convertToDomainModel() -> ListingVideo {
        guard let videoId = self.id?.videoId else {
            fatalError("SearchedItem MUTS contains id.")
        }

        guard let snippet = self.snippet else {
            fatalError("SearchedItem MUTS contains snippet.")
        }

        let thumbnail = ListingVideo.Thumbnail(
            // swiftlint:disable:next force_unwrapping
            default: URL(string: snippet.thumbnails.default.url)!,
            // swiftlint:disable:next force_unwrapping
            medium: URL(string: snippet.thumbnails.medium.url)!,
            // swiftlint:disable:next force_unwrapping
            high: URL(string: snippet.thumbnails.high.url)!
        )

        return .init(videoId: videoId,
                     title: snippet.title,
                     channelTitle: snippet.channelTitle,
                     publishedAt: snippet.publishedAt,
                     thumbnail: thumbnail)
    }
}
