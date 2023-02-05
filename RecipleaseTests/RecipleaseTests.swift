//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by laz on 14/12/2022.
//

import XCTest
@testable import Alamofire
@testable import Reciplease

final class RecipleaseTests: XCTestCase {
    
    private var viewModel: RecipeViewModel!
        
    override func setUp() {
        super.setUp()
        
        let manager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()
            
            return Session(configuration: configuration)
        }()
        
        viewModel = RecipeViewModel(session: manager)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testAddIngredientsShouldSuccessIfAddIngredients() {
        // when
        viewModel.addIngredients("Chicken, Cheese")

        // then
        XCTAssertEqual(viewModel.ingredients, ["Chicken", "Cheese"])
    }
    
    func testAddIngredientsShouldSuccessIfAddSameIngredients() {
        // when
        viewModel.addIngredients("Chicken, Cheese")
        viewModel.addIngredients("Chicken")

        // then
        XCTAssertEqual(viewModel.ingredients, ["Chicken", "Cheese"])
    }

    func testCleanIngredientListShouldSuccess() {
        // given
        viewModel.addIngredients("Chicken, Cheese")

        // when
        viewModel.clearIngredients()

        // then
        XCTAssertTrue(viewModel.ingredients.isEmpty)
    }

    func testSearchRecipesShouldFailIfStatusCodeError() {
        // given
        viewModel.addIngredients("Chicken, Cheese")
        MockURLProtocol.responseWithStatusCode(code: 404)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        viewModel.searchRecipes { success in
            // then
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }

    func testSearchRecipesShouldFailIfNoIngredient() {
        // given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        viewModel.searchRecipes { success in
            // then
            XCTAssertFalse(success)
            XCTAssertEqual(self.viewModel.recipes.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testSearchRecipesShouldSuccessIfIngredients() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        viewModel.searchRecipes { success in
            // then
            XCTAssertTrue(success)
            XCTAssertEqual(self.viewModel.recipes.count, 20)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadNextRecipesShouldSuccessIfNextExist() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        viewModel.searchRecipes { success in
            // then
            XCTAssertTrue(success)
            XCTAssertEqual(self.viewModel.recipes.count, 20)
            XCTAssertTrue(self.viewModel.hasNext)
            self.viewModel.loadNextRecipes { success in
                XCTAssertTrue(success)
                XCTAssertEqual(self.viewModel.recipes.count, 40)
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testLoadNextRecipesShouldFailIfNextDontExist() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        XCTAssertFalse(self.viewModel.hasNext)
        viewModel.loadNextRecipes { success in
            // then
            XCTAssertFalse(success)
            XCTAssertEqual(self.viewModel.recipes.count, 0)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testLoadNextRecipesShouldFailIfStatusCodeError() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // when
        viewModel.searchRecipes { success in
            MockURLProtocol.responseWithStatusCode(code: 404)
            
            // then
            self.viewModel.loadNextRecipes { success in
                XCTAssertFalse(success)
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 0.2)
    }
    
    func testAddToFavoriteShouldSuccess() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        viewModel.searchRecipes { success in
            // when
            let recipe = self.viewModel.recipes[0]
            self.viewModel.addFavorite(recipe)
            
            // then
            
            let isFavorite = self.viewModel.isFavorite(recipeId: recipe.id)
            XCTAssertTrue(isFavorite)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetFavortiesShouldSuccess() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        viewModel.searchRecipes { success in
            // when
            let recipe = self.viewModel.recipes[0]
            self.viewModel.addFavorite(recipe)
            
            // then
            
            self.viewModel.getFavorites { success in
                XCTAssertTrue(success)
                XCTAssertTrue(self.viewModel.favorites.count > 0)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testIsFavoriteShouldFailIfRecipeIsNotInFavorite() {
        //given
        let recipe = ModelData().edamam.recipes[11]
        
        // when
        let favorite = viewModel.isFavorite(recipeId: recipe.id)
        
        // then
        XCTAssertFalse(favorite)
    }
    
    func testRemoveFavoriteShouldSuccess() {
        // given
        viewModel.addIngredients("Chicken")
        
        MockURLProtocol.responseWithValidData()
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        viewModel.searchRecipes { success in
            // when
            let recipe = self.viewModel.recipes[0]
            self.viewModel.addFavorite(recipe)
            let isFavoriteT = self.viewModel.isFavorite(recipeId: recipe.id)
            XCTAssertTrue(isFavoriteT)
            
            // then
            self.viewModel.removeFavorite(recipe)
            let isFavoriteF = self.viewModel.isFavorite(recipeId: recipe.id)
            XCTAssertFalse(isFavoriteF)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
}
