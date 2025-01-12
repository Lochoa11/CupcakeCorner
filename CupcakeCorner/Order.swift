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
        case _specialRequestEnabled = "specialRequestEnabled"
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
    
    var name = "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "Name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "Address")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "City")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "Zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
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
        name = UserDefaults.standard.string(forKey: "Name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "Address") ?? ""
        city = UserDefaults.standard.string(forKey: "City") ?? ""
        zip = UserDefaults.standard.string(forKey: "Zip") ?? ""
    }
}
