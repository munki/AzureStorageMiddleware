//
//  AzureStorageMiddlewareTests.swift
//  AzureStorageMiddlewareTests
//
//  Created by Greg Neagle on 5/23/25.
//

import Testing

struct AzureStorageMiddlewareTests {
    

    @Test func buildURLWithSASWithoutLeadingQuestionMark() async throws {
        let url = "https://example.com"
        let sas = "foo=abc123"
        let expectedURL = "https://example.com?foo=abc123"
        #expect(buildAzureStorageURL(url, sas: sas) == expectedURL)
    }
    
    @Test func buildURLWithSASWithLeadingQuestionMark() async throws {
        let url = "https://example.com"
        let sas = "?foo=abc123"
        let expectedURL = "https://example.com?foo=abc123"
        #expect(buildAzureStorageURL(url, sas: sas) == expectedURL)
    }

}
