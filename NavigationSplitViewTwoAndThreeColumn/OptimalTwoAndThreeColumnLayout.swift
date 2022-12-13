//
//  OptimalTwoAndThreeColumnLayout.swift
//  NavigationSplitViewTwoAndThreeColumn
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct OptimalTwoAndThreeColumnLayout: View {
  @State private var selectedInt: Int? = 1
  @State private var columnVisibility: NavigationSplitViewVisibility = .all
  
  let items: [String] = (1...5).map { "Item \($0)" }
  
  var sidebarList: some View {
    List(1...5, id: \.self, selection: $selectedInt) { int in
      NavigationLink("Menu \(int)", value: int)
    }
    .navigationTitle("Sidebar")
    .navigationSplitViewColumnWidth(200)
//    .navigationSplitViewColumnWidth(min: 325, ideal: 325, max: 325)
  }
  
  var contentView: some View {
    VStack {
      Text("Content \(selectedInt ?? 0)")
        .font(.largeTitle)
      
      List(items, id: \.self) { item in
        NavigationLink(item, value: item)
      }
      .navigationDestination(for: String.self) { item in
        Text(item)
      }
    }
  }
  
  @ViewBuilder
  var detailView: some View {
    if selectedInt?.isMultiple(of: 2) == true {
      Text("Detail \(selectedInt ?? 0)")
    } else {
      Text("Please select an item.")
    }
  }
  
  var body: some View {
    Group {
      // Only rows that are a multiple of 2 will have a two-column layout
      if selectedInt?.isMultiple(of: 2) == true {
        NavigationSplitView(columnVisibility: $columnVisibility) {
          sidebarList
        } detail: {
          detailView
        }
      } else {
        NavigationSplitView(columnVisibility: $columnVisibility) {
          sidebarList
        } content: {
          contentView
        } detail: {
          detailView
        }
      }
    }
    .navigationSplitViewStyle(.balanced)
  }
}

struct OptimalTwoAndThreeColumnLayout_Previews: PreviewProvider {
  static var previews: some View {
    OptimalTwoAndThreeColumnLayout()
  }
}
