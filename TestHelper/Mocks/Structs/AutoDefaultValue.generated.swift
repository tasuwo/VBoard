// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT




@testable import Domain
@testable import Infrastructure
@testable import VBoardUIKit


extension ListingVideo {
    static func makeDefault(
            videoId: String = "",
            title: String = "",
            channelTitle: String = "",
            publishedAt: Date = Date(timeIntervalSince1970: 0),
            thumbnail: ListingVideo.Thumbnail = ListingVideo.Thumbnail.makeDefault()
    ) -> Self {
        return .init(
            videoId: videoId,
            title: title,
            channelTitle: channelTitle,
            publishedAt: publishedAt,
            thumbnail: thumbnail
        )
    }
}
extension ListingVideo.Thumbnail {
    static func makeDefault(
            `default`: URL = URL(string: "https://xxx.xxxx.xx")!,
            medium: URL? = nil,
            high: URL? = nil
    ) -> Self {
        return .init(
            `default`: `default`,
            medium: medium,
            high: high
        )
    }
}
extension PageInfo {
    static func makeDefault(
            totalResults: Int = 0,
            resultsPerPage: Int = 0,
            prevPageToken: String? = nil,
            nextPageToken: String? = nil
    ) -> Self {
        return .init(
            totalResults: totalResults,
            resultsPerPage: resultsPerPage,
            prevPageToken: prevPageToken,
            nextPageToken: nextPageToken
        )
    }
}
extension SearchQuery {
    static func makeDefault(
            query: String = "",
            sortOrder: SearchQuery.SortOrder = .date,
            length: SearchQuery.Length = .any,
            uploadDate: SearchQuery.UploadDate = .any,
            pageToken: String? = nil,
            pageSize: UInt = 0
    ) -> Self {
        return .init(
            query: query,
            sortOrder: sortOrder,
            length: length,
            uploadDate: uploadDate,
            pageToken: pageToken,
            pageSize: pageSize
        )
    }
}
extension YouTube.SearchApiResponse {
    static func makeDefault(
            kind: String = "",
            etag: String = "",
            nextPageToken: String? = nil,
            prevPageToken: String? = nil,
            pageInfo: YouTube.SearchApiResponse.PageInfo = YouTube.SearchApiResponse.PageInfo.makeDefault(),
            items: [YouTube.SearchedItem] = []
    ) -> Self {
        return .init(
            kind: kind,
            etag: etag,
            nextPageToken: nextPageToken,
            prevPageToken: prevPageToken,
            pageInfo: pageInfo,
            items: items
        )
    }
}
extension YouTube.SearchApiResponse.PageInfo {
    static func makeDefault(
            totalResults: Int = 0,
            resultsPerPage: Int = 0
    ) -> Self {
        return .init(
            totalResults: totalResults,
            resultsPerPage: resultsPerPage
        )
    }
}
extension YouTube.SearchRequest {
    static func makeDefault(
            parts: Set<YouTube.SearchRequest.Part> = [],
            filter: YouTube.SearchRequest.Filter? = nil,
            channelId: String? = nil,
            channelType: YouTube.SearchRequest.ChannelType? = nil,
            eventType: YouTube.SearchRequest.EventType? = nil,
            maxResults: UInt? = nil,
            onBehalfOfContentOwner: String? = nil,
            order: YouTube.SearchRequest.Order? = nil,
            pageToken: String? = nil,
            publishedAfter: Date? = nil,
            publishedBefore: Date? = nil,
            q: String? = nil,
            regionCode: YouTube.Country? = nil,
            safeSearch: YouTube.SearchRequest.SafeSearch? = nil,
            topicId: String? = nil,
            type: YouTube.SearchRequest.ResourceType? = nil,
            videoCaption: YouTube.SearchRequest.VideoCaption? = nil,
            videoCategoryId: String? = nil,
            videoDefinition: YouTube.SearchRequest.VideoDefinition? = nil,
            videoDimention: YouTube.SearchRequest.VideoDimension? = nil,
            videoDuration: YouTube.SearchRequest.VideoDuration? = nil,
            videoEmbeddable: YouTube.SearchRequest.VideoEmbeddable? = nil,
            videoLicense: YouTube.SearchRequest.VideoLicense? = nil,
            videoSyndicated: YouTube.SearchRequest.VideoSyndicated? = nil,
            videoType: YouTube.SearchRequest.VideoType? = nil
    ) -> Self {
        return .init(
            parts: parts,
            filter: filter,
            channelId: channelId,
            channelType: channelType,
            eventType: eventType,
            maxResults: maxResults,
            onBehalfOfContentOwner: onBehalfOfContentOwner,
            order: order,
            pageToken: pageToken,
            publishedAfter: publishedAfter,
            publishedBefore: publishedBefore,
            q: q,
            regionCode: regionCode,
            safeSearch: safeSearch,
            topicId: topicId,
            type: type,
            videoCaption: videoCaption,
            videoCategoryId: videoCategoryId,
            videoDefinition: videoDefinition,
            videoDimention: videoDimention,
            videoDuration: videoDuration,
            videoEmbeddable: videoEmbeddable,
            videoLicense: videoLicense,
            videoSyndicated: videoSyndicated,
            videoType: videoType
        )
    }
}
extension YouTube.SearchedItem {
    static func makeDefault(
            kind: String = "",
            etag: String = "",
            id: YouTube.SearchedItem.ResourceId? = nil,
            snippet: YouTube.SearchedItem.Snippet? = nil
    ) -> Self {
        return .init(
            kind: kind,
            etag: etag,
            id: id,
            snippet: snippet
        )
    }
}
extension YouTube.SearchedItem.ResourceId {
    static func makeDefault(
            kind: String = "",
            videoId: String? = nil,
            channelId: String? = nil,
            playlistId: String? = nil
    ) -> Self {
        return .init(
            kind: kind,
            videoId: videoId,
            channelId: channelId,
            playlistId: playlistId
        )
    }
}
extension YouTube.SearchedItem.Snippet {
    static func makeDefault(
            publishedAt: Date = Date(timeIntervalSince1970: 0),
            channelId: String = "",
            title: String = "",
            description: String = "",
            thumbnails: YouTube.SearchedItem.Snippet.Thumbnails = YouTube.SearchedItem.Snippet.Thumbnails.makeDefault(),
            channelTitle: String = ""
    ) -> Self {
        return .init(
            publishedAt: publishedAt,
            channelId: channelId,
            title: title,
            description: description,
            thumbnails: thumbnails,
            channelTitle: channelTitle
        )
    }
}
extension YouTube.SearchedItem.Snippet.Thumbnail {
    static func makeDefault(
            url: String = "",
            width: UInt = 0,
            height: UInt = 0
    ) -> Self {
        return .init(
            url: url,
            width: width,
            height: height
        )
    }
}
extension YouTube.SearchedItem.Snippet.Thumbnails {
    static func makeDefault(
            `default`: YouTube.SearchedItem.Snippet.Thumbnail = YouTube.SearchedItem.Snippet.Thumbnail.makeDefault(),
            medium: YouTube.SearchedItem.Snippet.Thumbnail = YouTube.SearchedItem.Snippet.Thumbnail.makeDefault(),
            high: YouTube.SearchedItem.Snippet.Thumbnail = YouTube.SearchedItem.Snippet.Thumbnail.makeDefault()
    ) -> Self {
        return .init(
            `default`: `default`,
            medium: medium,
            high: high
        )
    }
}
