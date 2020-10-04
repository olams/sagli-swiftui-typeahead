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

  var resultList:[String] = [
    "Ball", "Biler", "Biter", "Bitt" , "Binders", "Biller", "Bokser"
    
  ]
  var body: some View {
    
    VStack {
      
      TextField("Text", text: $text)
        .padding(20)
        .border(Color.black)
      
      ZStack {

        HStack {
          
          Text ( "One" )
          Text ("Two")
          Text("Four")
          
        }
        
        VStack {
                    
          let filteredResult = resultList.filter {
            return $0.starts(with: $text.wrappedValue)
          }
          
          if $text.wrappedValue.count > 1 {
            
            List (filteredResult, id:\.self) { word in

              TableViewCellView(textString: word)
              .onTapGesture() {
                
                print ("Tapped \(word)")
              }
            }
          }
        }
      }
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
      
        ContentView(text: "bil", resultList: ["bil", "bilene", "biler"])
    }
}
