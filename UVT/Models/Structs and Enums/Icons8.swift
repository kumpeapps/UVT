//
//  Icons8.swift
//  UVT
//
//  Created by Justin Kumpe on 7/27/22.
//

import UIKit

enum Icons8 {
    case ethernet
    case rj45
    case colorPalette
    case ipv4
    case pantex
    var urlString: String {
        switch self {
        case .ethernet, .rj45: return "https://img.icons8.com/color/96/000000/rj45.png"
        case .colorPalette: return "https://img.icons8.com/color/96/000000/color-palette.png"
        case .ipv4: return "https://img.icons8.com/external-others-phat-plus/64/000000/external-bulb-browser-and-interface-blue-others-phat-plus.png"
        case .pantex: return "https://img.icons8.com/ultraviolet/40/000000/pantex.png"
        }
    }
    var url: URL {
        return URL(string: self.urlString)!
    }
}
