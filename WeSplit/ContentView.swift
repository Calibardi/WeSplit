//
//  ContentView.swift
//  WeSplit
//
//  Created by Lorenzo Ilardi on 02/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        UserPickerView()
    }
}

struct FormView: View {
    @State private var tapCount: Int = 0
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("People counter")) {
                    Text("Count: \(tapCount)")
                    Button("Tap to increment") {
                        self.tapCount += 1
                    }
                }
                Section {
                    TextField("Enter your name", text: $name)
                } header: {
                    Text("Your name section")
                }
                
                Section {
                    HStack {
                        if !name.isEmpty {
                            Text("Hello, \(name)!")
                        } else {
                            Text("User unknown")
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                    }
                }
            }.navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.large)
        }.onAppear {
            print("Appeared")
        }
    }
}

struct UserPickerView: View {
    private let users: [String] = ["Harry", "Ron", "Hermione"]
    @State private var selectedUser: String = "Harry"
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select your student", selection: $selectedUser) {
                    ForEach(users, id: \.self) { user in
                        Text(user)
                    }
                }
                Spacer()
            }
            .navigationTitle("Pick a student")
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    ContentView()
}
