//
//  Extension+TableDirector.swift
//  Olimp
//
//  Created by Artem Balashov on 14/09/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
import TableKit

extension TableDirector {
    
    public func appendAndFill(_ section: TableSection, with rows: [Row], sectionIndex index: Int? = nil, animation: TableViewAnimation.Cell?, animated: Bool = true) {
        section.append(rows: rows)
        self.append(section: section)
        self.reload()
        if animated, let animation = animation, let index = self.index(of: section) {
            let indexPaths = rows.enumerated().map { IndexPath.init(row: $0.offset, section: index) }
            self.tableView?.animate(animation: animation, indexPaths: indexPaths, completion: nil)
        }
    }
    
    public func replaceRows(in section: TableSection, with rows: [Row], sectionIndex index: Int? = nil, animation: TableViewAnimation.Cell?, animated: Bool = true) {
        section.clear()
        section.append(rows: rows)
        self.reload()
        if animated, let animation = animation, let index = self.index(of: section) {
            let indexPaths = rows.enumerated().map { IndexPath.init(row: $0.offset, section: index) }
            self.tableView?.animate(animation: animation, indexPaths: indexPaths, completion: nil)
        }
    }
    
    public func index(of section: TableSection) -> Int? {
        return self.sections.firstIndex(where: {$0 === section})
    }
}
