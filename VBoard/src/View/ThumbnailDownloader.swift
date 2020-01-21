//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit

public enum ThumbnailDownloadError: Error {
    case failedToFetchData
    case invalidUrl
}

public protocol ThumbnailDowloaderProtocol {
    func startDownload(by url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    func cancelDownload()
}

public class ThumbnailDownloader: ThumbnailDowloaderProtocol {
    private let size: CGSize
    private var dataTask: URLSessionDataTask?

    public init(size: CGSize) {
        self.size = size
    }

    public func startDownload(by url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { fatalError() }
            guard let data = data else {
                completion(Result.failure(ThumbnailDownloadError.failedToFetchData))
                return
            }

            OperationQueue.main.addOperation {
                guard let image = UIImage(data: data) else {
                    completion(Result.failure(ThumbnailDownloadError.invalidUrl))
                    return
                }

                UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
                image.draw(in: CGRect(origin: .zero, size: self.size))
                completion(Result.success(image))
                UIGraphicsEndImageContext()
            }
        }

        dataTask?.resume()
    }

    public func cancelDownload() {
        dataTask?.cancel()
        dataTask = nil
    }
}
