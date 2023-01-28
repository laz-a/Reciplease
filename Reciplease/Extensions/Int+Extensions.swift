//
//  Int+Extensions.swift
//  Reciplease
//
//  Created by laz on 12/01/2023.
//

extension BinaryInteger {
    // Int to time
    var toTime: String {
        let int = Int(self)
        let hour = int / 60 > 0 ? "\(int / 60)h" : ""
        let minute = int % 60 > 0 ? String(format: "%02dm", int % 60) : ""
        
        let time = "\(hour)\(minute)"
        
        return time.isEmpty ? "N/A" : time
    }
    
    // Int to time
    var toAccessibleTime: String {
        let int = Int(self)
        let hour = int / 60 > 0 ? "\(int / 60) hours" : ""
        let minute = int % 60 > 0 ? String(format: "%02d minutes", int % 60) : ""
        
        let time = "\(hour) \(minute)"
        
        return time.isEmpty ? "Undefined" : time
    }
}
