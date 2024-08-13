//
//  Array+Extension.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

extension Array {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
