//
//  AzureStorageMiddlewareTests.swift
//  AzureStorageMiddlewareTests
//
//  Created by Greg Neagle on 5/23/25.
//

import Testing

struct AzureStorageMiddlewareTests {
    /// Test that the URL is built correctly if the SAS does not start with a "?"
    @Test func buildURLWithSASWithoutLeadingQuestionMark() async throws {
        let url = "https://example.com"
        let sas = "foo=abc123"
        let expectedURL = "https://example.com?foo=abc123"
        #expect(buildAzureStorageURL(url, sas: sas) == expectedURL)
    }

    /// Test that the URL is built correctly if the SAS starts with a "?"
    @Test func buildURLWithSASWithLeadingQuestionMark() async throws {
        let url = "https://example.com"
        let sas = "?foo=abc123"
        let expectedURL = "https://example.com?foo=abc123"
        #expect(buildAzureStorageURL(url, sas: sas) == expectedURL)
    }
    
    /// Test that a non-Azure request is returned unmodified
    @Test func nonAzureRequestShouldNotBeModified() async throws {
        let request = MunkiMiddlewareRequest(
            url: "https://example.com",
            headers: [:]
        )
        // currently MunkiMiddlewareRequest structs are not directly comparable, so we''ll just
        // compare the instance variables
        let processedRequest = AzureStorageMiddleware().processRequest(request)
        #expect(processedRequest.url == request.url)
        #expect(processedRequest.headers == request.headers)
    }
}
