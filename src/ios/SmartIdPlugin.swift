import Foundation
import SmartId

/// Please read the Capacitor iOS Plugin Development Guide
/// here: https://capacitorjs.com/docs/plugins/ios
@objc(SmartIdPlugin) class SmartIdPlugin: CDVPlugin {

  private let implementation = SmartIdPlugin()

  @objc(startSmartId:)
  func startSmartId(command: CDVInvokedUrlCommand) {
    SID.startLocation()

    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "The plugin succeeded")
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

   @objc(getRawData:)
   func getRawData(command: CDVInvokedUrlCommand) {
     let arguments = command.arguments
     var backendDomain: String = ""

     if arguments.count > 0 {
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
            self.commandDelegate!.send(result, callbackId: command.callbackId)
        } catch {
            let errorResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Error al crear el objeto JSON")
            self.commandDelegate!.send(errorResult, callbackId: command.callbackId)
        }
     })
     .onFailure(failure: {time, message, errorCode in
        let errorResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: message)
        self.commandDelegate!.send(errorResult, callbackId: command.callbackId)
     })
     .start()
   }

}
