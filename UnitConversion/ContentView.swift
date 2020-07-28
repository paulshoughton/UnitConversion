//
//  ContentView.swift
//  UnitConversion
//
//  Created by Paul Houghton on 26/07/2020.
//  Copyright © 2020 Paul Houghton. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var unitList: [String] = ["metres", "kilometres", "feet", "yards", "miles"]

    @State private var fromUnit: Int = 0
    @State private var toUnit: Int = 2
    @State private var originalValue: String = "1.0"
    
    var convertedValue: Double {
        let initialUnitValue: Measurement<UnitLength>
        let calculatedValue: Measurement<UnitLength>
        
        let value = Double(originalValue) ?? 1.0
        
        switch fromUnit {
        case 0:
            initialUnitValue = Measurement(value: value, unit: UnitLength.meters)
        case 1:
            initialUnitValue = Measurement(value: value, unit: UnitLength.kilometers)
        case 2:
            initialUnitValue = Measurement(value: value, unit: UnitLength.feet)
        case 3:
            initialUnitValue = Measurement(value: value, unit: UnitLength.yards)
        case 4:
            fallthrough
        default:
            // Assume miles if case is 4 or no value specified
            initialUnitValue = Measurement(value: value, unit: UnitLength.miles)
        }
        
        switch toUnit {
        case 0:
            calculatedValue = initialUnitValue.converted(to: UnitLength.meters)
        case 1:
            calculatedValue = initialUnitValue.converted(to: UnitLength.kilometers)
        case 2:
            calculatedValue = initialUnitValue.converted(to: UnitLength.feet)
        case 3:
            calculatedValue = initialUnitValue.converted(to: UnitLength.yards)
        case 4:
            fallthrough
        default:
            calculatedValue = initialUnitValue.converted(to: UnitLength.miles)
        }
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
                            Text("\(self.unitList[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                
                //To
                Section(header: Text("Convert to")) {
                    Picker("Convert to", selection: $toUnit) {
                        ForEach(0..<unitList.count) {
                            Text("\(self.unitList[$0])")
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
