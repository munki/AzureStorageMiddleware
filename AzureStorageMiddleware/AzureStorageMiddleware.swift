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

func buildAzureStorageURL(_ originalURL: String, sas: String) -> String {
    if sas.hasPrefix("?") {
        // assume sas has aready been encoded as a URL query
        // (as was the case for the original Python version)
        return originalURL + sas
    }
    return originalURL + "?" + sas
}

/// Adds a shared access signature to the request URL
class AzureStorageMiddleware: MunkiMiddleware {
    func processRequest(_ request: MunkiMiddlewareRequest) -> MunkiMiddlewareRequest {
        let azureEndpoint = pref("AzureEndpoint") as? String ?? "blob.core.windows.net"
        if !request.url.contains(azureEndpoint) {
            // return unmodified request
            return request
        }
        var modifiedRequest = request
        guard let sharedAccessSignature = pref("SharedAccessSignature") as? String else {
            print("ERROR: could not get SharedAccessSignature from preferences")
            return modifiedRequest
        }
        modifiedRequest.url = buildAzureStorageURL(modifiedRequest.url, sas: sharedAccessSignature)
        return modifiedRequest
    }
}

// MARK: dylib "interface"

final class AzureStorageMiddlewareBuilder: MiddlewarePluginBuilder {
    override func create() -> MunkiMiddleware {
        return AzureStorageMiddleware()
    }
}

/// Function with C calling style for our dylib.
/// We use it to instantiate the MunkiMiddleware object and return an instance
@_cdecl("createPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(AzureStorageMiddlewareBuilder()).toOpaque()
}
