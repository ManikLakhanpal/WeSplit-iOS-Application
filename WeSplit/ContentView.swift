//
//  ContentView.swift
//  WeSplit
//
//  Created by Manik Lakhanpal on 19/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalBill: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let grandTotal = totalBill
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Enter amount:")
                
                        Spacer()
                        
                        TextField("", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .focused($amountIsFocused) // When clicked amountIsFocused = true
                    }
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header: Text("How much tip do you want to leave? 💸")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result 💰") {
                    HStack {
                        Text("Total Bill:")
                        Spacer()
                        Text(totalBill, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                    }
                    HStack {
                        Text("Total Per Person:")
                        Spacer()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                    }
                }
            }
            .navigationTitle("WeSplit 🖖")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false // When done is pressed amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
