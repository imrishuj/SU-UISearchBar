//
//  ContentView.swift
//  DemoSearchBar
//
//  Created by Rishabh on 19/06/20.
//  Copyright © 2020 Rishabh. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var text: String = ""
    
    let nameAaray = ["Girijesh Kumar", "Rohit Pathak", "Shalu Chaudhary", "Sani Kumar", "Rishabh Jain","Anmol Maheshwari", "Arjun Maheshwari", "Lavi Bhardwaj", "Arun Kumar Saini"]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBarController(text: $text, placeholderText: "Search").navigationBarTitle(Text("Search Bar"))
                
                List {
                    ForEach(self.nameAaray.filter {
                        self.text.isEmpty ? true : $0.lowercased().contains(self.text.lowercased())
                    }, id: \.self) { name in
                        Text(name)
                    }
                }
            }
        }
    }
}

struct SearchBarController: UIViewRepresentable {
    
    @Binding var text: String
    var placeholderText: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholderText
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> SearchBarController.Coordinator {
        return Coordinator(text: $text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
