//
//  WeSplitHomeView.swift
//  WeSplit
//
//  Created by Lorenzo Ilardi on 02/04/25.
//

import SwiftUI

/*
 Wrap up challenge:
 
 1. Add a header to the third section, saying “Amount per person” - Done
 2 .Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people. - Done
 3. Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array. - Done, i preferred to use a wheel although
 4. Use a conditional modifier to change the total amount text view to red if the user selects a 0% tip - Done
        {
            Made the tip calculated amount red instead, and used a modifier extension rather than a conditional one
        }
 */

struct WeSplitHomeView: View {
    @State private var amount: Double? = nil
    @State private var splitBy: Int = 2
    @State private var tip: Int = 0
    @FocusState private var isAmountFocused: Bool
    
    private var tipAmount: Double? {
        guard let amount, amount > 0 else { return nil }
        return ((amount * Double(tip)) / 100)
    }
    
    private var totalPerPerson: Double? {
        guard let amount, amount > 0 else { return nil }
        let totalWithTip: Double = ((amount * Double(tip)) / 100) + amount
        return totalWithTip / Double(splitBy)
    }
    
    private let amountSummaryRow: (String, Double?) -> HStack = { title, amount in
        return HStack {
            Text(title)
            Spacer()
            Text(amount ?? 0.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                        .onChange(of: isAmountFocused) {
                            if $1 {
                                amount = nil
                            }
                        }
                    Picker("Number of attenders", selection: $splitBy) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section {
                    Picker("Tip", selection: $tip) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                } header: {
                    Text("Scroll to choose a tip")
                }
                
                Section {
                    amountSummaryRow("Total", amount)
                    amountSummaryRow("Tip", tipAmount)
                        .alerted(tipAmount == 0.0)
                }.listRowBackground(Color.clear)
                
                Section {
                    HStack {
                        Spacer()
                        Text(totalPerPerson ?? 0.0, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).font(.headline)
                        Spacer()
                    }
                    
                } footer: {
                    HStack {
                        Spacer()
                        Text("Per person")
                    }
                }
            }
            .listSectionSpacing(.custom(10))
            .navigationTitle("Splitter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if isAmountFocused {
                        HStack {
                            Spacer()
                            Button("Done") {
                                isAmountFocused = false
                            }
                            .font(Font.system(size: 17, weight: .bold, design: .default))
                            .foregroundStyle(Color.black)
                        }
                    }
                }
            }
        }
    }
}

#Preview("Home View") {
    WeSplitHomeView()
}

#Preview("Home View - Landscape", traits: .landscapeLeft) {
    WeSplitHomeView()
}
