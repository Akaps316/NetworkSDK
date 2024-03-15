import XCTest
@testable import NetworkSDK

final class NetworkSDKTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }


    func testFetchMoviesListSuccess() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        NetworkSDK.shared.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedMovies, "Fetched movies should not be nil")
        XCTAssertNil(fetchError, "Error fetching movies: \(fetchError?.localizedDescription ?? "")")
    }

    func testFetchMoviesListFailureInvalidAPIKey() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        let invalidApiKey = "INVALID_API_KEY"
        let networkSDK = NetworkSDK(apiKey: invalidApiKey)
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListFailureInvalidURL() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        let invalidURL = "invalid-url"
        let networkSDK = NetworkSDK(baseURL: invalidURL)
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListFailureNoInternetConnection() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        // Simulate no internet connection by using invalid host
        let invalidHost = "http://invalidhost"
        let networkSDK = NetworkSDK(baseURL: invalidHost)
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListFailureEmptyResponse() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        // Simulate empty response
        let networkSDK = NetworkSDK(baseURL: "https://www.emptyresponse.com")
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListFailureServerError() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        // Simulate server error
        let networkSDK = NetworkSDK(baseURL: "https://www.servererror.com")
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListFailureTimeout() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        // Simulate timeout
        let networkSDK = NetworkSDK(baseURL: "https://www.delayedresponse.com")
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }

    func testFetchMoviesListDecoding() {
        // Given
        let expectation = self.expectation(description: "Fetch movies list")
        var fetchedMovies: [Movie]?
        var fetchError: Error?

        // When
        // Simulate successful response with invalid JSON
        let networkSDK = NetworkSDK(baseURL: "https://www.invalidjsonresponse.com")
        networkSDK.fetchMoviesList { (movies, error) in
            fetchedMovies = movies
            fetchError = error
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovies, "Fetched movies should be nil")
        XCTAssertNotNil(fetchError, "Expected error fetching movies")
    }
}

