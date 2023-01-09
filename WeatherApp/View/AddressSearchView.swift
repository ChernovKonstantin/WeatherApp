//
//  AddressSearchView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 06.01.2023.
//

import SwiftUI
import MapKit

struct AddressSearchView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SearchManager
    @State private var query = ""
    @State private var selection = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.searchResults, id: \.self) { item in
                HStack {
                    Text(item.title + ", " + item.subtitle)
                    Spacer()
                }
                .frame(height: 44)
                .padding()
                .onTapGesture {
                    viewModel.selection = item
                    dismiss()
                }
            }
            .searchable(text: $query, prompt: "Search")
            .onChange(of: query, perform: { newQuery in
                viewModel.searchCompleter.queryFragment = newQuery
            })
            .onDisappear() {
                viewModel.reset()
        }
        }
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView(viewModel: SearchManager())
    }
}
