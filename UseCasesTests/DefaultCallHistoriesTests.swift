//
//  DefaultCallHistoriesTests.swift
//  Telephone
//
//  Copyright (c) 2008-2016 Alexey Kuznetsov
//  Copyright (c) 2016 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import XCTest
import UseCases
import UseCasesTestDoubles

final class DefaultCallHistoriesTests: XCTestCase {
    func testSetsHistoryOnDidAddAccount() {
        let sut = DefaultCallHistories(factory: CallHistoryFactoryStub(history: TruncatingCallHistory()))
        let accountID = "any"

        sut.didAdd(SimpleAccount(uuid: accountID), to: UserAgentSpy())

        XCTAssertFalse(sut.history(forAccountWithID: accountID).isNil)
    }

    func testRemovesHistoryOnWillRemoveAccount() {
        let sut = DefaultCallHistories(factory: CallHistoryFactoryStub(history: TruncatingCallHistory()))
        let account = SimpleAccount(uuid: "any")
        sut.didAdd(account, to: UserAgentSpy())

        sut.willRemove(account, from: UserAgentSpy())

        XCTAssertTrue(sut.history(forAccountWithID: account.uuid).isNil)
    }
}
