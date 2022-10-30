import UIKit
import Foundation

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

struct Mobile: Hashable {
    let imei: String
    let model: String
}

extension Mobile: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.imei == rhs.imei
    }
}

protocol MobileStorageProtocol {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}


class MobileStorage: MobileStorageProtocol {
    
    private var allMobile: Set<Mobile> = []

    func getAll() -> Set<Mobile> {
        allMobile
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        allMobile.first(where: {$0.imei == imei})
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        guard !allMobile.contains(where: {$0 == mobile}) else { throw NSError(domain: "Included this imei", code: 1) }
        allMobile.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        guard allMobile.remove(product) != nil else { throw NSError(domain: "This phone is not in the list", code: 3) }
    }
    
    func exists(_ product: Mobile) -> Bool {
        allMobile.contains(product)
    }
}


