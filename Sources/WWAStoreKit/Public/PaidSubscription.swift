//
// Copyright © 2022-2023 WitworkApp. All rights reserved.
//

import Foundation
import SwiftDate
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
    
    return formatter
}()

public struct PaidSubscription {
    
    public var productId: String
    public let purchaseDate: Date
    public let expiresDate: Date
    public var is_trial_period: Bool
    public var isActive: Bool {
        if self.is_trial_period == true  {
            return true
        }
        return (purchaseDate...expiresDate).contains(Date())
    }
    init(productId: String, purchaseDate: Date, expiresDate: Date, is_trial_period: Bool) {
        self.productId = productId
        self.purchaseDate = purchaseDate
        self.expiresDate = expiresDate
        self.is_trial_period = is_trial_period
    }
    init?(json: [String: Any]) {
        guard
            let productId = json["product_id"] as? String,
            let purchaseDateString = json["purchase_date"] as? String,
            let purchaseDate = purchaseDateString.toISODate()?.date, //dateFormatter.date(from: purchaseDateString),
            let expiresDateMs = json["expires_date_ms"] as? String
            else {
                
                return nil
        }
        let expiresDate = Date(timeIntervalSince1970: ((Double(expiresDateMs) ?? 0) / 1000.0))
        self.productId = productId
        self.purchaseDate = purchaseDate
        self.expiresDate = expiresDate
        self.is_trial_period = json["is_trial_period"] as? Bool ?? false
    }
}


extension PaidSubscription {
    init?(data: Data) {
        if let coding = NSKeyedUnarchiver.unarchiveObject(with: data) as? Encoding {
            productId = coding.productId as String
            purchaseDate = coding.purchaseDate as Date
            expiresDate = coding.expiresDate as Date
            is_trial_period = coding.is_trial_period as Bool
        } else {
            return nil
        }
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: Encoding(self))
    }
    
    @objc(_TtCV13Wallpaper_Now16PaidSubscription8Encoding)class Encoding: NSObject, NSCoding {
        
        let productId: NSString
        let purchaseDate: NSDate
        let expiresDate: NSDate
        let is_trial_period: Bool
        init(_ paid: PaidSubscription) {
            productId = paid.productId as NSString
            purchaseDate = paid.purchaseDate as NSDate
            expiresDate = paid.expiresDate as NSDate
            is_trial_period = paid.is_trial_period as Bool
        }
        
        @objc required init?(coder aDecoder: NSCoder) {
            self.productId = aDecoder.decodeObject(forKey: "productId") as! NSString
            self.purchaseDate = aDecoder.decodeObject(forKey: "purchaseDate") as! NSDate
            self.expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as! NSDate
            self.is_trial_period = aDecoder.decodeBool(forKey: "is_trial_period")
        }
        
        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(productId, forKey: "productId")
            aCoder.encode(purchaseDate, forKey: "purchaseDate")
            aCoder.encode(expiresDate, forKey: "expiresDate")
            aCoder.encode(is_trial_period, forKey: "is_trial_period")
        }
    }
}
