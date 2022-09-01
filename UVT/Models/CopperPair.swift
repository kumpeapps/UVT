//
//  CopperPair.swift
//  UVT
//
//  Created by Justin Kumpe on 8/2/22.
//

import UIKit

struct CopperPair {
    let pair: Int!
    let basePair: Int!
    let binder: Int!
    let superBinder: Int!
    let tip: String!
    let ring: String!
    let binderTip: String!
    let binderRing: String!
    let superBinderTip: String!
    let superBinderRing: String!
    let tipColor: UIColor!
    let ringColor: UIColor!
    let binderRingColor: UIColor!
    let binderTipColor: UIColor!
    let superBinderRingColor: UIColor!
    let superBinderTipColor: UIColor!
    init(pair: Int) {
        self.pair = pair
        var superBinder: Int {
            switch pair {
            case 1...625:
                return 1
            case 626...1250:
                return 2
            case 1251...1875:
                return 3
            case 1876...2500:
                return 4
            case 2501...3125:
                return 5
            case 3126...3750:
                return 6
            case 3751...4375:
                return 7
            case 4376...5000:
                return 8
            case 5001...5625:
                return 9
            case 5626...6250:
                return 10
            case 6251...6875:
                return 11
            case 6876...7500:
                return 12
            case 7501...8125:
                return 13
            case 8126...8750:
                return 14
            case 8751...9375:
                return 15
            case 9376...10000:
                return 16
            case 10001...10625:
                return 17
            case 10626...11250:
                return 18
            case 112551...11875:
                return 19
            case 11876...12500:
                return 20
            case 12501...13125:
                return 21
            case 13126...13750:
                return 22
            case 13751...14375:
                return 23
            case 14376...15000:
                return 24
            case 15001...15625:
                return 25
            default:
                return 0
            }
        }

        self.superBinder = superBinder
        let superBinderSub = (superBinder - 1) * 625
        let baseBinderPair = pair - superBinderSub

        var binder: Int {
            switch baseBinderPair {
            case 1...25:
                return 1
            case 26...50:
                return 2
            case 51...75:
                return 3
            case 76...100:
                return 4
            case 101...125:
                return 5
            case 126...150:
                return 6
            case 151...175:
                return 7
            case 176...200:
                return 8
            case 201...225:
                return 9
            case 226...250:
                return 10
            case 251...275:
                return 11
            case 276...300:
                return 12
            case 301...325:
                return 13
            case 326...350:
                return 14
            case 351...375:
                return 15
            case 376...400:
                return 16
            case 401...425:
                return 17
            case 426...450:
                return 18
            case 451...475:
                return 19
            case 476...500:
                return 20
            case 501...525:
                return 21
            case 526...550:
                return 22
            case 551...575:
                return 23
            case 576...600:
                return 24
            case 601...625:
                return 25
            default:
                return 0
            }
        }
        self.binder = binder
        let binderSub = (binder - 1) * 25
        let basePair = baseBinderPair - binderSub
        self.basePair = basePair
        self.tip = getTip(basePair)
        self.ring = getRing(basePair)
        self.binderTip = getTip(self.binder)
        self.binderRing = getRing(self.binder)
        self.superBinderTip = getTip(self.superBinder)
        self.superBinderRing = getRing(self.superBinder)
        self.tipColor = getColor(self.tip)
        self.ringColor = getColor(self.ring)
        self.binderTipColor = getColor(self.binderTip)
        self.binderRingColor = getColor(self.binderRing)
        self.superBinderTipColor = getColor(self.superBinderTip)
        self.superBinderRingColor = getColor(self.superBinderRing)
    }
}

private func getTip(_ pair: Int) -> String {
    switch pair {
    case 1...5:
        return "white"
    case 6...10:
        return "red"
    case 11...15:
        return "black"
    case 16...20:
        return "yellow"
    case 21...25:
        return "violet"
    default:
        return "unknown"
    }
}

private func getRing(_ pair: Int) -> String {
    switch pair {
    case 1, 6, 11, 16, 21:
        return "blue"
    case 2, 7, 12, 17, 22:
        return "orange"
    case 3, 8, 13, 18, 23:
        return "green"
    case 4, 9, 14, 19, 24:
        return "brown"
    case 5, 10, 15, 20, 25:
        return "slate"
    default:
        return "unknown"
    }
}

private func getColor(_ color: String) -> UIColor {
    switch color {
    case "blue":
        return .blue
    case "orange":
        return .orange
    case "green":
        return .green
    case "brown":
        return .brown
    case "slate":
        return .gray
    case "white":
        return .white
    case "red":
        return .red
    case "black":
        return .black
    case "yellow":
        return .yellow
    case "violet":
        return .purple
    default:
        return .clear
    }
}
