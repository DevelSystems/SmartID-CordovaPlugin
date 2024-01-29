//
//  BridgeSmartId.swift
//  BANRURAL
//
//  Created by BDGSA on 9/4/20.
//

import Foundation
import SmartId

@objcMembers class BridgeSmartId: NSObject {
    
    func startSmartId() {
        SID.startLocation()
    }

    func getRawData(commandDelegate: CDVCommandDelegate, command: CDVInvokedUrlCommand) {
        let arguments = command.arguments
             var backendDomain: String = ""

        if (arguments?.count ?? 0) > 0 {
            backendDomain = String(describing: command.arguments[0])
        }

        SID.shared
            .getRawData(applicationBackendDomain: backendDomain)
            .onSuccess(success: {time, response in
                do {
                    let jsonObject: [String: Any] = [
                        "data": response
                        ]

                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: jsonString)
                    commandDelegate.send(result, callbackId: command.callbackId)
                } catch {
                    let errorResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Error al crear el objeto JSON")
                    commandDelegate.send(errorResult, callbackId: command.callbackId)
                }
            })
            .onFailure(failure: {time, message, errorCode in
                let errorResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: message)
                commandDelegate.send(errorResult, callbackId: command.callbackId)
            })
            .start()
    }

}
