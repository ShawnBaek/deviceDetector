//
//  File.swift
//  
//
//  Created by Sungwook Baek on 2022/05/14.
//

import Foundation
import UIKit

extension UIDevice {
    private enum Identifier {
        static let simulator = "Simulator"
        enum iPhone {
            static let plus = "Plus"
            static let old = ["6", "7", "8"]
            static let x = ["X", "XS"]
            static let pro = "Pro"
            static let max = "Max"
            static let mini = "mini"
        }
        enum iPad {
            static let air = "Air"
            static let pro = "Pro"
            static let mini = "mini"
            static let pro9_7 = "9.7"
            static let pro10_5 = "10.5"
            static let pro12_9 = "12.9"
            static let pro11 = "11"
        }
    }
    
    func device(name: String?) -> DeviceSet {
        guard let deviceName = name else {
            return .unrecognized
        }
        switch deviceName {
        case let model where model.starts(with: DeviceSet.iPhoneSet.name):
            return iPhone(model: model)
        case let model where model.starts(with: DeviceSet.iPadSet.name):
            return iPad(model: model)
        case let model where model.starts(with: DeviceSet.iPod.name):
            return .iPod
        default:
            return .unrecognized
        }
    }
    
    func deviceName(id: String? = nil, dict: NSDictionary) -> String? {
        var identifier = ""
        if let id = id {
            identifier = id
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        guard var deviceName = dict.value(forKey: identifier) as? String else {
            return nil
        }
        if deviceName == UIDevice.Identifier.simulator, let simulatorDeviceIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            if let simulatorDeviceName = dict.value(forKey: simulatorDeviceIdentifier) as? String {
                deviceName = simulatorDeviceName
            }
            else {
                return nil
            }
        }
        return deviceName
    }
}

extension UIDevice {
    private func iPhone(model: String) -> DeviceSet {
        if model.starts(with: DeviceSet.iPhoneSESet.name) {
            if model == DeviceSet.iPhoneSE1.name {
                return .iPhoneSE1
            }
            else if model == DeviceSet.iPhoneSE2.name {
                return .iPhoneSE2
            }
            else {
                return .iPhoneSE3
            }
        }
        else if Identifier.iPhone.old.filter({ model.contains($0) }).count > 0 {
            if model.contains(Identifier.iPhone.plus) {
                if model.starts(with: DeviceSet.iPhone6S.name) {
                    return .iPhone6SPlus
                }
                else if model.starts(with: DeviceSet.iPhone7.name) {
                    return .iPhone7Plus
                }
                else {
                    return .iPhone8Plus
                }
            }
            else {
                if model == DeviceSet.iPhone6S.name {
                    return .iPhone6S
                }
                else if model == DeviceSet.iPhone7.name {
                    return .iPhone7
                }
                else {
                    return .iPhone8
                }
            }
        }
        else if model.starts(with: DeviceSet.iPhoneX.name) {
            if model == DeviceSet.iPhoneXR.name {
                return .iPhoneXR
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneXSMax
            }
            else {
                if model == DeviceSet.iPhoneX.name {
                    return .iPhoneX
                }
                else {
                    return .iPhoneXS
                }
            }
        }
        else if model.starts(with: DeviceSet.iPhone11.name) {
            if model == DeviceSet.iPhone11.name {
                return .iPhone11
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        else if model.starts(with: DeviceSet.iPhone12.name) {
            if model == DeviceSet.iPhone12.name {
                return .iPhone12
            }
            else if model.contains(Identifier.iPhone.mini) {
                return .iPhoneMini
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        else if model.starts(with: DeviceSet.iPhone13.name) {
            if model == DeviceSet.iPhone13.name {
                return .iPhone13
            }
            else if model.contains(Identifier.iPhone.mini) {
                return .iPhoneMini
            }
            else if model.contains(Identifier.iPhone.max) {
                return .iPhoneProMax
            }
            else {
                return .iPhonePro
            }
        }
        return .unrecognized
    }
    
    private func iPad(model: String) -> DeviceSet {
        if model.contains(Identifier.iPad.air) {
            return .iPadAir
        }
        else if model.contains(Identifier.iPad.pro) {
            if model.contains(Identifier.iPad.pro9_7) {
                return .iPadPro9_7inch
            }
            else if model.contains(Identifier.iPad.pro10_5) {
                return .iPadPro10_5inch
            }
            else if model.contains(Identifier.iPad.pro11) {
                return .iPadPro11inch
            }
            else if model.contains(Identifier.iPad.pro12_9) {
                return .iPadPro12_9inch
            }
        }
        else if model.contains(Identifier.iPad.mini) {
            return .iPadMini
        }
        else {
            if model == DeviceSet.iPad5.name {
                return .iPad5
            }
            else if model == DeviceSet.iPad6.name {
                return .iPad6
            }
            else if model == DeviceSet.iPad7.name {
                return .iPad7
            }
            else if model == DeviceSet.iPad8.name {
                return .iPad8
            }
            else if model == DeviceSet.iPad9.name {
                return .iPad9
            }
        }
        return .unrecognized
    }
}
