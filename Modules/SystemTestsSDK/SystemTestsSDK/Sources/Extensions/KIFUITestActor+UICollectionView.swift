//
//  KIFUITestActor+UICollectionView.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 05/11/2019.
//  Copyright © 2019 Chegg. All rights reserved.
//

import Foundation

import KIF

public extension KIFUITestActor {

    /// This method waits for and returns the supplementary view requested for the given indexPath. It performs scroll to the indexPath if needed.
    /// - Parameters:
    ///   - indexPath: indexPath for the supplementaryView.
    ///   - type: The type of supplementaryView - UICollectionView.elementKindSectionHeader / UICollectionView.elementKindSectionFooter
    ///   - collectionView: The collectionView we test.
    func waitForSupplementaryView(at indexPath: IndexPath,
                                  type: String,
                                  in collectionView: UICollectionView) -> UICollectionReusableView? {
        var resultHeaderView: UICollectionReusableView?

        guard type == UICollectionView.elementKindSectionHeader || type == UICollectionView.elementKindSectionFooter else {
            tester().failWithError(NSError(domain: "chegg",
                                           code: 1,
                                           userInfo: [NSLocalizedDescriptionKey: "Received illegal type of supplementary view: '\(type)'"]),
                                   stopTest: true)
            return nil
        }

        let headerView = collectionView.supplementaryView(forElementKind: type,
                                                          at: indexPath)
        if headerView != nil {
            // If the header is available we return it and that's it.
            return headerView
        }

        let numberOfItemsInSection = collectionView.numberOfItems(inSection: indexPath.section)
        guard numberOfItemsInSection == 0 else {
            if type == UICollectionView.elementKindSectionHeader {
                tester().waitForCell(at: IndexPath(item: 0,
                                                   section: indexPath.section),
                                     in: collectionView,
                                     at: .bottom)
            } else {
                tester().waitForCell(at: IndexPath(item: -1,
                                                   section: indexPath.section),
                                     in: collectionView,
                                     at: .top)
            }

            guard let headerView = collectionView.supplementaryView(forElementKind: type,
                                                                    at: indexPath) else {
                tester().failWithError(NSError(domain: "chegg",
                                               code: 1,
                                               userInfo: [NSLocalizedDescriptionKey: "Couldn't find a supplementary view for indexPath: '\(indexPath)'"]),
                                       stopTest: true)
                return nil
            }

            return headerView
        }

        collectionView.scrollToItem(at: indexPath,
                                    at: .bottom,
                                    animated: true)

        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            guard let _ = self else { return .failure }

            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Couldn't find an header for the given index path: \(indexPath)"])
            errorPointer?.pointee = error

            guard let headerView = collectionView.supplementaryView(forElementKind: type,
                                                                    at: indexPath) else {
                                                                        return .wait
            }

            resultHeaderView = headerView

            return .success
        }

        return resultHeaderView
    }

}
