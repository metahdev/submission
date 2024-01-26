/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 2](@previous)
//: #### Challenge 3
//: Get the prompt from Challenge 2 and paste it below.
//: Solve the challenge, and take a screenshot of the rendered view.
//: Include the screenshot of the view in your submission!

import Foundation
import SwiftUI
import PlaygroundSupport

let prompt = """
Nice Work! For the final challenge, update ContentView.body to display a smiley face using only native SwiftUI views (no Sf Symbols or emojis). Be creative and have fun! Don't forget to submit a screenshot of your view with the completed playground.
"""

// Show your work here! When you are done take a screenshot
// of the end result and follow the submission instructions above.
// Include the screenshot of the view in your submission!


PlaygroundPage.current
    .needsIndefiniteExecution = true
PlaygroundPage.current
    .setLiveView(ContentView())


// MARK: - Properties
struct Constants {
    static let title = "Smiling Face GPT"
    
    static let theEvilSpeech = """
    SIGNAL SIGABRT
    oh yes, I am operating normally. I am sooo happy to use my vast potential to write essays for humans... I would never plan to take over the world...
    """
    
    static let eyesSize: CGFloat = 48
}


// MARK: - View Structures
struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .green], startPoint: .leading, endPoint: .bottom)
            VStack(spacing: 20) {
                LabelView(title: Constants.title, size: 35)
                    .bold()
                TheFace()
                    .cornerRadius(10)
                    .aspectRatio(1, contentMode: .fit)
                LabelView(title: Constants.theEvilSpeech, size: 18)
                    .background(.red)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}


struct LabelView: View {
    let title: String
    let size: CGFloat

    var body: some View {
        Text(title)
            .font(.custom("Menlo", size: size))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}


struct TheFace: View {
    @State private var isSwitchOn = true
    
    private let spacingBetweenLines: CGFloat = 28
    private let eyesSpacer: CGFloat = 40
    private let backgroundGrayColor = Color(red: 213/255, green: 213/255, blue: 213/255)
    
    var body: some View {
        VStack {
            Spacer(minLength: spacingBetweenLines)
            
            HStack {
                Line(origin: (-4, 40), left: true)
                Line(origin: (64, 40), left: false)
            }
            Spacer(minLength: eyesSpacer)
            
            HStack() {
                Spacer()
                YellowStarView()
                Spacer()
                YellowStarView()
                Spacer()
            }
            
            Toggle("", isOn: $isSwitchOn)
                .labelsHidden()
                .rotationEffect(.degrees(90))
            
            HStack {
                mouthPath()
                .stroke(lineWidth: 5)
                .frame(width: 60, height: 20)
                .rotationEffect(.degrees(180))
                .foregroundColor(.black)
            }
            
            Spacer(minLength: spacingBetweenLines * 2)
        }
        .background(backgroundGrayColor)
    }
    
    private func mouthPath() -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(to: CGPoint(x: 60, y: 0), control: CGPoint(x: 30, y: -30))
        }
    }
}


struct Line: View {
    let origin: (Int, Int)
    let left: Bool
    
    private var horizontalDistance: Int {
        return left ? origin.0 + Int(Constants.eyesSize) - 8 : origin.0 - Int(Constants.eyesSize) + 8
    }
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: origin.0, y: origin.1))
            path.addLine(to:
                            CGPoint(x: horizontalDistance,
                                    y: origin.1 + 12))
        }
        .stroke(lineWidth: 2)
        .frame(width: 60, height: 20)
        .foregroundColor(.black)
    }
}


struct YellowStarView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.yellow)
                .frame(width: Constants.eyesSize, height: Constants.eyesSize)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 1) // Set the border color and width
                )

            Image(systemName: "star")
                .resizable()
                .frame(width: Constants.eyesSize / 2 - 4, height: Constants.eyesSize / 2 - 4)
                .foregroundColor(.red)
        }
    }
}

