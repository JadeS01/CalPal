//
//  MenuView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: ProfileView()){
                    Image(systemName: "person")
                        .foregroundColor(.green)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.green)
                        .font(.headline)
                }
            }.padding(.top, 100)
            
            HStack {
                NavigationLink(destination: LogView()){
                    Image(systemName: "plus.circle")
                        .foregroundColor(.green)
                        .imageScale(.large)
                    Text("Log")
                        .foregroundColor(.green)
                        .font(.headline)
                }
            }.padding(.top, 30)
            
            HStack {
                NavigationLink(destination: StatsView()){
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.green)
                            .imageScale(.large)
                        Text("Statistics")
                            .foregroundColor(.green)
                            .font(.headline)
                    }
                }
            }.padding(.top, 30)
            // Spacer() pushes up menu items
            Spacer()
            Picker("Theme", selection: $isDarkMode){
                Text("Light").tag(false)
                Text("Dark").tag(true)
            }.pickerStyle(.segmented).padding()
            
        }.padding().frame(maxWidth: .infinity, alignment: .leading)
//            .background(.white)
//            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
//                        .edgesIgnoringSafeArea(.all)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
