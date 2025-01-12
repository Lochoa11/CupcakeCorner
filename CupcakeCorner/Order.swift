//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lin Ochoa on 1/10/25.
//

import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "spcialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encoded, forKey: "Address")
            }
        }
    }
    var city = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "City")
            }
        }
    }
    var zip = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encoded, forKey: "Zip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        if let savedItem = UserDefaults.standard.data(forKey: "Address") {
            if let decodedItem = try? JSONDecoder().decode(String.self, from: savedItem) {
                streetAddress = decodedItem
            }
        }
        if let savedItem = UserDefaults.standard.data(forKey: "City") {
            if let decodedItem = try? JSONDecoder().decode(String.self, from: savedItem) {
                city = decodedItem
            }
        }
        if let savedItem = UserDefaults.standard.data(forKey: "Zip") {
            if let decodedItem = try? JSONDecoder().decode(String.self, from: savedItem) {
                zip = decodedItem
            }
        }
    }
}
