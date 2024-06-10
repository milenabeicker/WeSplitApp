//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Milena Beicker on 09/06/24.
//


import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let localCurrency = Locale.current.currency?.identifier ??  "USD"
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var valorComGorjeta: Double {
        let tipSelection1 = Double(tipPercentage)
        
        let somaTotalComGorjeta = checkAmount / 100 * tipSelection1
        return checkAmount + somaTotalComGorjeta
        
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Valor da conta ") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section("Divisão da conta") {
                    Picker("Numero de pessoas", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }
                }
                
                Section ("Gorjeta"){
                    Picker("Quanto de gorjeta você quer deixar?", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section ("Valor total com gorjeta ") {
                    Text(valorComGorjeta, format: .currency(code: localCurrency))
                }
                
                Section ("Valor final por pessoa ") {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
