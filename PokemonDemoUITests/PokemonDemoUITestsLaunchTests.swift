//
//  PokemonDemoUITestsLaunchTests.swift
//  PokemonDemoUITests
//
//  Created by MacBook on 13/05/2025.
//

import XCTest

final class PokemonDemoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
            continueAfterFailure = false
        }

        func testPokemonListLoadsAndTapsFirstItem() throws {
            let app = XCUIApplication()
            app.launch()

            // Wait for the list to load (max 10 seconds)
            let firstCell = app.cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "The Pokémon list did not load in time.")

            // Tap the first item
            firstCell.tap()

            // Check that we navigated to the detail screen
            let detailTitle = app.staticTexts["Details"]
            XCTAssertTrue(detailTitle.exists || app.navigationBars["Details"].exists, "Failed to navigate to the detail screen.")
        }

        func testSearchFiltersPokemonList() throws {
            let app = XCUIApplication()
            app.launch()

            let searchField = app.searchFields.firstMatch
            XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search bar not found.")

            searchField.tap()
            searchField.typeText("pikachu")

            // Assert list is filtered
            let filteredCell = app.cells.containing(.staticText, identifier: "Pikachu").firstMatch
            XCTAssertTrue(filteredCell.waitForExistence(timeout: 5), "Filtered Pokémon not found.")
        }
}
