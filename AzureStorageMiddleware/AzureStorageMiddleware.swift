//
//  AzureStorageMiddleware.swift
//  AzureStorageMiddlewareMiddleware
//
//  Created by Greg Neagle on 5/10/25.
//  A proof-of-concept port of Oliver Kieselbach's Azure Storage middleware
//  https://github.com/okieselbach/Munki-Middleware-Azure-Storage
//

import Foundation

let BUNDLE_ID = "ManagedInstalls" as CFString

/// read a preference
func pref(_ prefName: String) -> Any? {
    return CFPreferencesCopyAppValue(prefName as CFString, BUNDLE_ID)
}

/// Adds a shared access signature to the request URL
class AzureStorageMiddleware: MunkiMiddleware {
    func processRequest(_ request: MunkiMiddlewareRequest) -> MunkiMiddlewareRequest {
        let sharedAccessSignature = pref("SharedAccessSignature") as? String ?? ""
        let azureEndpoint = pref("AzureEndpoint") as? String ?? "blob.core.windows.net"

        var modifiedRequest = request
        if modifiedRequest.url.contains(azureEndpoint) {
            modifiedRequest.url = modifiedRequest.url + sharedAccessSignature
        }
        return modifiedRequest
    }
}

// MARK: dylib "interface"

/// Function with C calling style for our dylib. We use it to instantiate the Repo object and return an instance
@_cdecl("createPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(AzureStorageMiddlewareBuilder()).toOpaque()
}

final class AzureStorageMiddlewareBuilder: MiddlewarePluginBuilder {
    override func create() -> MunkiMiddleware {
        return AzureStorageMiddleware()
    }
}
