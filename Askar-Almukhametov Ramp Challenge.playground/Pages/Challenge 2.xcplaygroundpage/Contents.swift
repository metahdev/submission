/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 1](@previous)
//: #### Challenge 2
//: Get the prompt from Challenge 1 and paste it below.
//: Solve the challenge to get the prompt for Challenge 3.

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let prompt = "Great job! \n\nNext we've hosted a JSON file at at this url: https://api.jsonbin.io/v3/b/646bed328e4aa6225ea22a79. Your job is to write a script to\ndownload the contents of the URL (hint: The X-ACCESS-KEY is $2b$10$Ke1iwieFO7/7qsSKU.GYU.oYXZMW1EeHrwd4xx9ylboJik5mstZk6)\nsort the data by each elements 'bar' key\nfilter out elements where 'baz' is not divisible by 3\nconcatenate each elements 'foo' value\n\nDo each of these steps to reveal the instructions for the final part. Remember to show your work!"

// Show your work here! When you are done move on to Challenge 3

var prompt3 = ""

// MARK: - Codable Structures
struct DataUnit: Codable {
    let foo: String
    let bar: Int
    let baz: Int
}

struct Record: Codable {
    let data: [DataUnit]
}

struct ResponseData: Codable {
    let record: Record
}

    
// MARK:- Downloading
func fetchData() {
    guard let url = URL(string: "https://api.jsonbin.io/v3/b/646bed328e4aa6225ea22a79") else {
        print("Wrong URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.setValue("$2b$10$Ke1iwieFO7/7qsSKU.GYU.oYXZMW1EeHrwd4xx9ylboJik5mstZk6", forHTTPHeaderField: "X-ACCESS-KEY")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ResponseData.self, from: data)

                // Filter elements where baz is divisible by 3
                let filteredData = decodedData.record.data.filter { $0.baz % 3 == 0 }

                // Sort by bar key
                let sortedData = filteredData.sorted { $0.bar < $1.bar }

                // Concatenate each foo value
                prompt3 = sortedData.map { $0.foo }.joined(separator: "")
            } catch {
                print("Error: \(error)")
            }
        }
    }.resume()
}

fetchData()
//: [Challenge 3](@next)
