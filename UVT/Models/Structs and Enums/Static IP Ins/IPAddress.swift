//
//  IPAddress.swift
//  UVT
//
//  Created by Justin Kumpe on 7/27/22.
//

import UIKit

struct IPAddress {
    var firstOctet: Int
    var secondOctet: Int
    var thirdOctet: Int
    var fourthOctet: Int
    var string: String {
        return "\(firstOctet).\(secondOctet).\(thirdOctet).\(fourthOctet)"
    }
}
