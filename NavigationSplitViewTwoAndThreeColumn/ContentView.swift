//
//  ContentView.swift
//  MY-NavigationViewWithIpad
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct ContentView: View {
  private var items: [String] = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ]
  
  enum TopMenuItem: String, Identifiable, CaseIterable {
    case activeWeek = "Active Week",
         allWeeks = "All Weeks"
    
    var id: Self { self }
  }
  
  @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
  @State private var topNav: TopMenuItem?
  
  var navList: some View {
    List(selection: $topNav) {
      ForEach(TopMenuItem.allCases) { nav in
        Text(nav.rawValue)
          .tag(nav)
      }
    }
    .listStyle(.sidebar)
  }
  
  var twoColumnLayout: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      navList
    } detail: {
      VStack {
        Text("Two Column Layout")
          .font(.largeTitle)
        
        Text("Jibberjabber")
        Text("Jibberjabber")
        Text("Jibberjabber")
        Text("Jibberjabber")
        Text("Jibberjabber")
      }
    }
  }
  
  var threeColumnLayout: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      navList
    } content: {
      if topNav == .activeWeek {
        Text("Active Week")
      } else if topNav == .allWeeks {
        List(items, id: \.self) { item in
          NavigationLink(item, value: item)
        }
        .listStyle(.insetGrouped)
        .navigationDestination(for: String.self) { item in
          Text("\(item) at NavigationDestination")
        }
      } else {
        Text("Please select a nav item")
      }
    } detail: {
      Text("Please select an item")
    }
  }
  
  var body: some View {
    Group {
      if topNav == .allWeeks {
        threeColumnLayout
      } else {
        twoColumnLayout
      }
    }
    .navigationSplitViewStyle(.balanced)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
