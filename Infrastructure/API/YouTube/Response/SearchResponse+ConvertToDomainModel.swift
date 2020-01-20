//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import Domain

extension YouTube.SearchedItem {
    func convertToDomainModel() -> ListingVideo {
        guard let videoId = self.id?.videoId else {
            fatalError()
        }

        guard let snippet = self.snippet else {
            fatalError()
        }

        let thumbnail = ListingVideo.Thumbnail(default: URL(string: snippet.thumbnails.default.url)!,
                                               medium: URL(string: snippet.thumbnails.medium.url)!,
                                               high: URL(string: snippet.thumbnails.high.url)!)

        return .init(videoId: videoId,
                     title: snippet.title,
                     channelTitle: snippet.channelTitle,
                     publishedAt: snippet.publishedAt,
                     thumbnail: thumbnail)
    }
}
