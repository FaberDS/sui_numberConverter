//
//  ContentView.swift
//  Shared
//
//  Created by Denis Schüle on 26.10.21.
//

import SwiftUI

struct ContentView: View {
    private var inputSystem = [2:"Binary",8:"Octal",10:"Decimal",16:"Hexadecimal"]
    @State private var numbInput = ""
    @State private var selectedBase = 2
    @State private var decimal : UInt64 = 0
    
    var body: some View {
        VStack {
            HStack {
                Menu {
                    ForEach(inputSystem.sorted(by: <),id: \.key){ base,name in
                        Button {
                            selectedBase = base
                        } label: {
                            Text(name)
                        }
                    }
                } label: {
                    Text("Input format")
                    Image(systemName: "chevron.down")
                }
                Spacer()
                Button {
                    numbInput = ""
                    selectedBase = 2
                } label: {
                    Image(systemName: "xmark.circle")
                }

            }

            HStack {
                TextField("Your input", text: $numbInput)
                    .onChange(of: numbInput) {
                        decimal = UInt64($0,radix: selectedBase) ?? 0
                                }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Text("\(selectedBase)")
            }
            ZStack {
                Color("CardBackgroundColor")
                VStack(spacing: 10) {
                    ForEach(inputSystem.sorted(by: <),id: \.key){ base,name in
                        NumberLine(example: numberSystemResult(forBase: base), base: "\(base)")
                    }
                }.padding()
            }
            .frame(height:200)
            .cornerRadius(10)
            .shadow(radius:3)
            .padding(.top,5)
        }.padding()
    }
    func numberSystemResult(forBase base : Int ) -> String {
        if let decimal = UInt64(numbInput, radix: selectedBase) {
            return String(decimal, radix: base).uppercased()
        }
        return "-"
    }
}
struct NumberLine : View {
    var example : String
    var base : String
    var body : some View {
        HStack(alignment: .bottom,spacing: 0.0) {
            Spacer()
            Text(example)
                .font(.title)
                .padding(.trailing,10)
                .minimumScaleFactor(0.8)
            Text(base)
                .minimumScaleFactor(0.2)

        }.foregroundColor(.white)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
