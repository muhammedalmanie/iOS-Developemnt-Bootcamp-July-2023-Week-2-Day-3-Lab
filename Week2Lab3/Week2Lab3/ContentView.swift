//
//  ContentView.swift
//  MySwiftUIApp
//
//  Created by Muhammed on 8/1/23.

import SwiftUI

// MARK: Observable Object
class Data: ObservableObject {
    @Published var data: Int = 50
}

// MARK: Main View
struct ContentView: View {
    
    // MARK: Passing Data Between Views
    @State private var passNumber: Int = 50
    
    // MARK: Using @State
    // MARK: changes the view's appearance (Dark Mode)
    @State private var isDarkMode = false
    
    // MARK: an instance of the ObservableObject
    @StateObject private var dataStore = Data()

    var body: some View {
        NavigationView {
            VStack {
                Text("Passing the number to the next view")
                Circle()
                    .foregroundColor(.red)
                    .frame(width: 150, height: 150)
                    .overlay(Text("\(passNumber)").foregroundColor(.white))
                    .navigationTitle("Red One")
                    .font(.system(size: 40, weight: .bold))
                    .navigationBarTitleDisplayMode(.inline)
                
                    .padding(20)

                NavigationLink(destination: SecondView(receivedNumber: $passNumber), label: {
                    Text("Next Screen")
                        .bold()
                        .foregroundColor(.primary)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.primary, lineWidth: 2))
                        
                })
                
                Toggle(isOn: $isDarkMode, label: {
                    Label("Dark Mode", systemImage: "moon.circle.fill")
                })
                .padding(50)
                
                // MARK: Implement a button in the main view to update the data and see the UI reflect the changes
                Text("Using @ObservableObject")
                Text("Data: \(dataStore.data)")
                    .font(.system(size: 30, weight: .bold))
                    .padding(10)

                Button("Update Data") {
                    dataStore.data += 5
                }
                .foregroundColor(.primary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.primary, lineWidth: 2)
                )
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

// MARK: Second View
struct SecondView: View {
    @Binding var receivedNumber: Int
    
    var body: some View {
        VStack {
            Text("Received the number from the main view")
                .multilineTextAlignment(.center)
                .padding(70)
            Circle()
                .foregroundColor(.blue)
                .frame(width: 150, height: 150)
                .overlay(Text("\(receivedNumber)").foregroundColor(.white))
                .padding()
                .navigationTitle("Blue Two")
                .font(.system(size: 40, weight: .bold))
                .offset(y: -60)
            
            NavigationLink(destination: ThirdView(receivedNumber: $receivedNumber), label: {
                Text("Next Screen")
                    .bold()
                    .foregroundColor(.primary)
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.primary, lineWidth: 2))
            })
    
        }
    }
}

// MARK: Using @binding
// a custom SwiftUI View that contains a text field and a button.

struct TextFieldView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Update") {
                text = "Updated!"
            }
            .bold()
            .foregroundColor(.primary)
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 25)
            .stroke(Color.primary, lineWidth: 2))
        }
    }
}

// MARK: Third View
struct ThirdView: View {
    @State private var inputText = ""
    @Binding var receivedNumber: Int
    
    var body: some View {
        VStack {
            TextFieldView(text: $inputText)
                .padding()
            
            Text("Entered Text: \(inputText)")
                .padding()
        }
        .navigationTitle("Using @binding")
    }    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
