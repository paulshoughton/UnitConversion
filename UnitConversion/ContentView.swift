//
//  ContentView.swift
//  UnitConversion
//
//  Created by Paul Houghton on 26/07/2020.
//  Copyright © 2020 Paul Houghton. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let unitList: [(UnitLength, String)] = [
        (.meters, "metres"),
        (.kilometers, "kilometres"),
        (.feet, "feet"),
        (.yards, "yards"),
        (.miles, "miles")
    ]
    
    @State private var fromUnit: Int = 0
    @State private var toUnit: Int = 2
    @State private var originalValue: String = "1.0"
    
    var convertedValue: Double {
        let initialUnitValue: Measurement<UnitLength>
        let calculatedValue: Measurement<UnitLength>
        
        let value = Double(originalValue) ?? 1.0
        
        initialUnitValue = Measurement(value: value, unit: unitList[fromUnit].0)
        calculatedValue = initialUnitValue.converted(to: unitList[toUnit].0)
        
        return calculatedValue.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                //Original Value
                Section(header: Text("Length")) {
                    TextField("Value", text: $originalValue)
                        .keyboardType(.decimalPad)
                }

                //From
                Section(header: Text("Convert from")) {
                    Picker("Convert from", selection: $fromUnit) {
                        ForEach(0..<unitList.count) {
                            Text("\(self.unitList[$0].1)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                
                //To
                Section(header: Text("Convert to")) {
                    Picker("Convert to", selection: $toUnit) {
                        ForEach(0..<unitList.count) {
                            Text("\(self.unitList[$0].1)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Converted value is
                Section(header: Text("Converted Value")) {
                    Text("\(convertedValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Convert")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
