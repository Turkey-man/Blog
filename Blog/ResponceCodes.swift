//
//  ResponceCodes.swift
//  Blog
//
//  Created by 1 on 28.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

public enum ResponseStatusCode: Int {
    //    Informational
    case `continue` = 100, switchingProtocols, processing
    //Success
    case success = 200, created, accepted, nonAuthoritativeInformation, noContent, resetContent, partialContent, multiStatus, alreadyReported
    case imUsed = 226
    //Redirection
    case multipleChoices = 300, movedPermanently, found, seeOther, notModified, useProxy
    case temporaryRedirect = 307, permanentRedirect
    //Client Error
    case badRequest = 400, unauthorized, paymentRequired, forbidden, notFound, methodNotAllowed, notAcceptable, proxyAuthenticationRequired, requestTimeout, conflict, gone, lengthRequired, preconditionFailed, payloadTooLarge, requestURITooLong, unsupportedMediaType, requestedRangeNotSatisfiable, expectationFailed, teapot, misdirectedRequest, unprocessableEntity, locked, failedDependency, upgradeRequired, preconditionRequired, tooManyRequests
    
    case requestHeaderFieldsTooLarge = 431
    case connectionClosedWithoutResponse = 444
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
    //Server Error
    case internalServerError = 500, notImplemented, badGateway, serviceUnavailable,gatewayTimeout, httpVersionNotSupported, variantAlsoNegotiates, insufficientStorage, loopDetected, notExtended, networkAuthenticationRequired
    case networkConnectTimeoutError = 599
}
