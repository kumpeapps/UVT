//
//  IPBlock.swift
//  UVT
//
//  Created by Justin Kumpe on 7/27/22.
//

import UIKit

// Calculated IP Info based on start ip and block size for Uverse Static IPs
struct IPInfo {
    let blockSize: Int
    let networkAddress: IPAddress
    let firstUsable: IPAddress
    let lastUsable: IPAddress
    let defaultGateway: IPAddress
    let subnetMask: String
    let attPrimaryDNS: String = "68.94.156.1"
    let attSecondaryDNS: String = "68.94.157.1"
    init(startIP: IPAddress, blockSize: Int) {
        self.networkAddress = startIP
        self.blockSize = blockSize
        self.firstUsable = IPAddress(firstOctet: startIP.firstOctet, secondOctet: startIP.secondOctet, thirdOctet: startIP.thirdOctet, fourthOctet: startIP.fourthOctet + 1)
        self.lastUsable = IPAddress(firstOctet: startIP.firstOctet, secondOctet: startIP.secondOctet, thirdOctet: startIP.thirdOctet, fourthOctet: startIP.fourthOctet + blockSize - 3)
        self.defaultGateway = IPAddress(firstOctet: startIP.firstOctet, secondOctet: startIP.secondOctet, thirdOctet: startIP.thirdOctet, fourthOctet: startIP.fourthOctet + blockSize - 2)
        self.subnetMask = {
            switch blockSize {
            case 8:
                return "255.255.255.248"
            case 16:
                return "255.255.255.240"
            case 32:
                return "255.255.255.224"
            case 64:
                return "255.255.255.192"
            default:
                return "ERROR"
            }
        }()
    }
}
