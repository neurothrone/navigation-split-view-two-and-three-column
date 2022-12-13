//
//  TwoAndThreeColumnLayout.swift
//  MY-NavigationViewWithIpad
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

struct TwoAndThreeColumnLayout: View {
  @State private var selectedInt: Int? = 1
  @State private var columnVisibility: NavigationSplitViewVisibility = .all
  
  let items: [String] = (1...5).map { "Item \($0)" }
  
  @State private var selectedItem: String?
  
  var sidebarList: some View {
    List(1...10, id: \.self, selection: $selectedInt) { int in
      NavigationLink("Row \(int)", value: int)
    }
    .navigationTitle("Sidebar")
  }
  
  var contentView: some View {
    VStack {
      Text("Content \(selectedInt ?? 0)")
        .font(.largeTitle)
      
      List(selection: $selectedItem) {
        ForEach(items, id: \.self) { item in
          Text(item)
        }
      }
    }
  }
  
  @ViewBuilder
  var detailView: some View {
    if selectedInt?.isMultiple(of: 2) == true {
      Text("Detail \(selectedInt ?? 0)")
    } else {
      VStack {
        if let selectedItem {
          Text(selectedItem)
        } else {
          Text("Please select an item.")
        }
      }
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

struct TwoAndThreeColumnLayout_Previews: PreviewProvider {
  static var previews: some View {
    TwoAndThreeColumnLayout()
  }
}
