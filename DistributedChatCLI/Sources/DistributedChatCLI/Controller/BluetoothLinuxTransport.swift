#if os(Linux)
import DistributedChat
import Foundation
import Logging

import Bluetooth
import BluetoothHCI
import BluetoothGATT
import BluetoothLinux
import GATT

fileprivate let log = Logger(label: "BluetoothLinuxTransport")

// TODO: Ideally move these constants into a module shared with the CoreBluetooth version

/// Custom UUID specifically for the 'Distributed Chat' service
fileprivate let serviceUUID = UUID(uuidString: "59553ceb-2ffa-4018-8a6c-453a5292044d")!
/// Custom UUID specific to the characteristic holding the L2CAP channel's PSM (see below)
fileprivate let characteristicUUID = UUID(uuidString: "440a594c-3cc2-494a-a08a-be8dd23549ff")!

public struct BluetoothLinuxTransport: ChatTransport {
    private let l2CapServer: L2CAPSocket

    public init() throws {
        guard let hostController = BluetoothLinux.HostController.default else { throw BluetoothLinuxError.noHostController }
        log.info("Found host controller \(hostController.identifier) with address \(try! hostController.readDeviceAddress())")

        l2CapServer = try L2CAPSocket.lowEnergyServer()
        log.info("Opened L2CAP server with PSM \(l2CapServer.protocolServiceMultiplexer)")

        let gattCentral = GATTCentral<BluetoothLinux.HostController, BluetoothLinux.L2CAPSocket>(hostController: hostController)
        do {
            try gattCentral.scan(foundDevice: handle(data:))
        } catch {
            throw BluetoothLinuxError.bleScanFailed("Try relaunching the application using sudo!")
        }
    }

    private func handle(data: ScanData<Peripheral, GATTCentral<HostController, L2CAPSocket>.Advertisement>) {
        log.info("Got GATT advertising event: \(data.peripheral.identifier) with \(data.advertisementData) (RSSI: \(data.rssi), connectable: \(data.isConnectable))")
    }

    public func broadcast(_ raw: String) {
        // TODO
    }

    public func onReceive(_ handler: @escaping (String) -> Void) {
        // TODO
    }
}
#endif
