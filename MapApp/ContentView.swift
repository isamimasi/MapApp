//
//  ContentView.swift
//  MapApp
//
//  Created by F. ISAMI. on 2024/05/09.
//

import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    @State var displaySearchKey: String = "広島駅"
    @State var displayMapType: MapType = .standard
    var body: some View {
        ///Vstack↓↓↓↓↓↓↓
        VStack {
            TextField("keyword", text: $inputText, prompt: Text ("input keyword"))
                .onSubmit {
                    displaySearchKey = inputText
                }
                .padding()
            //Zstack↓↓↓↓↓↓↓
            ZStack(alignment: .bottomTrailing){
                //Map View
                MapView(searchKey: displaySearchKey, mapType: displayMapType)
                // Button Display
                // button ↓↓↓↓↓↓↓
                Button {
                    if displayMapType == .standard {
                        displayMapType = .satelite
                        print (displayMapType)
                    }
                    else if displayMapType == .satelite {
                        displayMapType = .hybrid
                        print (displayMapType)
                    }
                    else {
                        displayMapType = .standard
                        print (displayMapType)
                    }
                }label: {
                    Image (systemName: "map")
                        .resizable()
                        .frame(width: 35, height: 35)
                } //button ↑↑↑↑↑↑↑
                .padding(.trailing, 20.0)
                .padding(.bottom, 30)
            }//Zstack↑↑↑↑↑↑↑
            //.padding()
        }
        ///Vstack↑↑↑↑↑↑↑
    }}

#Preview {
    ContentView()
}
