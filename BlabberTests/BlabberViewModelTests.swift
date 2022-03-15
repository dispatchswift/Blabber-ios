import XCTest
@testable import Blabber

class BlabberViewModelTests: XCTestCase {
	
	let model: BlabberViewModel = {
		let model = BlabberViewModel()
		model.username = "test"
		
		let testConfiguration = URLSessionConfiguration.default
		testConfiguration.protocolClasses = [TestURLProtocol.self]
	
		// TestURLProtocol will handle all the network calls made by this instance
		model.urlSession = URLSession(configuration: testConfiguration)
		return model
	}()
	
	func testModelSay() async throws {
		try await model.sendMessage("Hello!")
		
		// Verify that the model sends data to the correct endpoint.
		let request = try XCTUnwrap(TestURLProtocol.lastRequest)
		XCTAssertEqual(request.url?.absoluteString, "http://localhost:8080/chat/sendMessage")
		
		// Verify that the correct data was sent.
		let httpBody = try XCTUnwrap(request.httpBody)
		let message = try XCTUnwrap(try? JSONDecoder().decode(Message.self, from: httpBody))
		XCTAssertEqual(message.message, "Hello!")
	}
}
