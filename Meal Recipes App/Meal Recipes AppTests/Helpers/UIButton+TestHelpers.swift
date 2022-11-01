//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Amin faruq on 19/09/22.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
