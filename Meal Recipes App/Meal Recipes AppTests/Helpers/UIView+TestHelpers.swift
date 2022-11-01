//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Amin faruq on 03/10/22.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
