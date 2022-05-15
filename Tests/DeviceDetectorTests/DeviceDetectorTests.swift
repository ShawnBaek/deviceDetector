import XCTest
@testable import DeviceDetector

final class DeviceDetectorTests: XCTestCase {
    private var devicesDict: NSDictionary!
    
    override func setUp() async throws {
        let resourcePath = Bundle.module.path(forResource: "Device", ofType: "plist")
        devicesDict = NSDictionary(
            contentsOfFile: resourcePath ?? ""
        )
    }
    
    func test_all_devices_from_plist() throws {
        devicesDict.allKeys.compactMap { $0 as? String }.forEach {
            XCTAssertNotEqual(DeviceDetector.shared.device(id: $0), .unrecognized)
        }
    }
    
    func test_iPad() throws {
        let iPad5th = ["iPad6,11", "iPad6,12"]
        let iPad6th = ["iPad7,5", "iPad7,6"]
        let iPad7th = ["iPad7,11", "iPad7,12"]
        let iPad8th = ["iPad11,6", "iPad11,7"]
        let iPad9th = ["iPad12,1", "iPad12,1"]
        
        iPad5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad5)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (5th generation) should be of iPad")
        }
        iPad6th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad6)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (6th generation) should be of iPad")
        }
        iPad7th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad7)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (7th generation) should be of iPad")
        }
        iPad8th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad8)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (8th generation) should be of iPad")
        }
        iPad9th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPad9)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad (9th generation) should be of iPad")
        }
    }
    
    func test_iPadAir() throws {
        let iPaAir2 = ["iPad5,3", "iPad5,4"]
        let iPaAir3rd = ["iPad11,3", "iPad11,4"]
        let iPadAir4th = ["iPad13,1", "iPad13,2"]
        let iPadAir5th = ["iPad13,16", "iPad13,17"]
        
        iPaAir2.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air 2 should be of iPad")
        }
        iPaAir3rd.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (3rd generation) should be of iPad")
        }
        iPadAir4th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (4th generation) should be of iPad")
        }
        iPadAir5th.forEach {
            let device = DeviceDetector.shared.device(id: $0)
            XCTAssertEqual(device, .iPadAir)
            XCTAssertTrue(DeviceSet.iPad.contains(device), "iPad Air (5th generation) should be of iPad")
        }
    }
}
