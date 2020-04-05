//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import UIKit
import VBoardUIKit

class ContentThumbnailViewController: UITableViewController{
    @IBOutlet weak var largeThumbnail: ContentThumbnail!
    @IBOutlet weak var smallThumbnail: ContentThumbnail!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.largeThumbnail.thumbnailUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "thumbnail_16_9", ofType: "png")!)
        self.smallThumbnail.thumbnailUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "thumbnail_4_3", ofType: "png")!)
    }
}
