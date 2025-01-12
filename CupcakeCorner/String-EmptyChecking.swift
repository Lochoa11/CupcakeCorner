//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Lin Ochoa on 1/12/25.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
