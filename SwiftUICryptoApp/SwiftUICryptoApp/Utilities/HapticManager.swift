//
//  HapticManager.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 09.09.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
