//
//  KIFUITestActor+UITableView.swift
//  SystemTestsSDK
//
//  Created by Maor Karo on 27/04/2020.
//  Copyright © 2020 Chegg. All rights reserved.
//

import Foundation
import KIF

public extension KIFUITestActor {

    /// This method waits for and returns the section header view requested for the given indexPath. It performs scroll to the indexPath if needed.
    /// If you would like to get the footer section, extend this method and get a reference from KIFUITestActor+UICollectionView (waitForSupplementaryView)
    /// - Parameters:
    ///   - indexPath: indexPath for the reusableView.
    ///   - collectionView: The tableView we test.
    func waitForReusableHeaderView(at indexPath: IndexPath,
                                  in tableView: UITableView) -> UITableViewHeaderFooterView? {
        var resultHeaderView: UITableViewHeaderFooterView?

        let headerView = tableView.headerView(forSection: indexPath.section)

        if headerView != nil {
            // If the header is available we return it and that's it.
            return headerView
        }

        tableView.scrollToRow(at: indexPath,
                              at: .none,
                              animated: true)

        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            guard let _ = self else { return .failure }

            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Couldn't find an header for the given index path: \(indexPath)"])
            errorPointer?.pointee = error

            guard let headerView = tableView.headerView(forSection: indexPath.section) else {
                                                                        return .wait
            }

            resultHeaderView = headerView

            return .success
        }

        return resultHeaderView
    }

}
