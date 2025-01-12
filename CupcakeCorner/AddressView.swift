//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Lin Ochoa on 1/10/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(addressValidation())
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)        
    }
    
    func addressValidation() -> Bool {
        if order.hasValidAddress == false {
            return true
        }
        
        let checkName = order.name.trimmingCharacters(in: .whitespaces)
        let checkStreetAddress = order.streetAddress.trimmingCharacters(in: .whitespaces)
        let checkCity = order.city.trimmingCharacters(in: .whitespaces)
        let checkZip = order.zip.trimmingCharacters(in: .whitespaces)
        
        if checkName == "" {
            return true
        }
        
        if checkStreetAddress == "" {
            return true
        }
        
        if checkCity == "" {
            return true
        }
        
        if checkZip == "" {
            return true
        }
        
        return false
    }
}

#Preview {
    AddressView(order: Order())
}
