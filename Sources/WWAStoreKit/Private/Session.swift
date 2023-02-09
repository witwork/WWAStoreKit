//
// Copyright © 2022-2023 WitworkApp. All rights reserved.
//

import Foundation
typealias SessionId = String

struct Session {
    let id: SessionId
    var paidSubscriptions: [PaidSubscription]
    
    var currentSubscription: PaidSubscription? {
        let activeSubscriptions = paidSubscriptions.filter { $0.isActive }
        let sortedByMostRecentPurchase = activeSubscriptions.sorted { $0.purchaseDate > $1.purchaseDate }
        return sortedByMostRecentPurchase.first
    }
    
    var receiptData: Data
    var parsedReceipt: [String: Any]
    
    init(receiptData: Data, parsedReceipt: [String: Any]) {
        id = UUID().uuidString
        self.receiptData = receiptData
        self.parsedReceipt = parsedReceipt
        
        if let receipt = parsedReceipt["receipt"] as? [String: Any], let purchases = receipt["in_app"] as? Array<[String: Any]> {
            var subscriptions = [PaidSubscription]()
            for purchase in purchases {
                if let paidSubscription = PaidSubscription(json: purchase) {
                    subscriptions.append(paidSubscription)
                }
            }
            
            paidSubscriptions = subscriptions
        } else {
            paidSubscriptions = []
        }
    }
    
}

// MARK: - Equatable

extension Session: Equatable {
    static func ==(lhs: Session, rhs: Session) -> Bool {
        return lhs.id == rhs.id
    }
}
