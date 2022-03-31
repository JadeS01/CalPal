//
//  HomeViewController.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct HomeViewController: View {
    
    @State var showMenu = false
    
    
    var body: some View {
        
        let closeMenu = DragGesture()
            .onEnded{
                if $0.translation.width < -100{
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            
            GeometryReader{ geometry in
            
                ZStack(alignment: .trailing){
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
    //                MainView()
    //                    .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu {
                        MenuView().frame(width: geometry.size.width/2.22)
                            .transition(.move(edge: .trailing))
                    }
                }.gesture(closeMenu)
            }
            .navigationBarTitle("Cal-Pal", displayMode: .inline)
             
            .navigationBarItems(trailing: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                    }
            ))
            .navigationBarItems(leading: (
                Text("LOGO")))
        }
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
//        Button(action: {
//            withAnimation {
//                self.showMenu = true
//            }
//        }) {
//            Text("Show menu")
//        }
        Text("This is the home view!")
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}

