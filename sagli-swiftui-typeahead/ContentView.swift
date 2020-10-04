//
//  ContentView.swift
//  sagli-swiftui-typeahead
//
//  Created by Ola Marius Sagli on 04/10/2020.
//

import SwiftUI

struct TableViewCellView : View {

  @State var textString:String
  
  var body : some View {
    
    HStack {
      Text(textString)
      Spacer()
    }
    .contentShape(Rectangle())
    .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
  }
  
}

struct ContentView: View {
  
  @State var text:String = ""
  @State var suggestionResult:[String] = []
  @State var searchResult:[String] = []
  
  func createSuggestionResult() {
    suggestionResult = []
    for s in [ "Planets", "Panic", "Plan", "Pouring", "Earth", "Evening" ] {
      suggestionResult.append(s)
    }
  }
  
  func createSearchResult(){
    searchResult = []
    for w in [ "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus"] {
      searchResult.append(w)
    }
  }
  
  var shouldShowSuggestions:Bool {
    get {
      return self.searchResult.count == 0 && self.$text.wrappedValue.count > 2
    }
  }
  var body: some View {
    
    List {
      
      Section( header:
                
            VStack {

              TextField(
                "",
                text: $text
              )
              .padding(20)
              .border(Color.black)
              .onChange(of: text, perform: { value in
                
                if $text.wrappedValue.count == 2 {
                  createSuggestionResult()
                }
                else if ($text.wrappedValue.count < 2) {
                  self.suggestionResult = []
                }
              })
              
              HStack {
                Text ("Action 1")
                Text ("Action 2")
                Text("Action 3")
              }
            }
      ) {
       
        let filteredResult = suggestionResult.filter {
          return $0.starts(with: $text.wrappedValue)
        }
        
        ForEach (filteredResult, id:\.self) { word in

          TableViewCellView(textString: word)
          .onTapGesture() {
            suggestionResult = []
            createSearchResult()
          }
        }

        
        ForEach (searchResult, id:\.self) { w in
          Text (w)
        }

      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
      
        ContentView(text: "bil", suggestionResult: ["bil", "bilene", "biler"])
    }
}
