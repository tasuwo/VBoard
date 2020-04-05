//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import VBoardUIKit

class ContentContainerViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ContentContainerViewController {
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ContentContainer.preferredHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ContentContainerTableView.reuseIdentifier) as? ContentContainer else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            cell.title = "First Video"
            cell.duration = 0
            cell.uploadDate = Date(timeIntervalSince1970: 0)
            cell.thumbnailUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "thumbnail_16_9", ofType: "png")!)
        case 1:
            cell.title = "Second Video"
            cell.duration = 15 + 60 * 15 + 3600 * 15
            cell.uploadDate = Date(timeIntervalSince1970: 0)
            cell.thumbnailUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "thumbnail_4_3", ofType: "png")!)
        case 2:
            cell.title = "Too long title text sample. abcdefghijklmnopqrstuvwxyz"
            cell.duration = 999999
            cell.uploadDate = Date(timeIntervalSince1970: 0)
            cell.thumbnailUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "thumbnail_16_9", ofType: "png")!)
        default:
            break
        }

        return cell
    }
}
