//
//  LocationNameView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 04.01.2023.
//

import SwiftUI

struct LocationNameView: View {
    var location: String
    var date: String
    var action: AnyView
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("place")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20.0, height: 20.0)
                
                NavigationLink(destination: action, label: {
                    Text(location)
                        .foregroundColor(.mainWhite)
                        .font(.system(size: 24))
                })
                
//                Button(action: action, label: {
//                    Text(location)
//                        .foregroundColor(.mainWhite)
//                        .font(.system(size: 24))
//                })
                
            }
            Text(date)
                .foregroundColor(.mainWhite)
                .font(.system(size: 16))
        }
        .padding()
    }
}

struct LocationNameView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.mainDarkBlue.ignoresSafeArea()
            LocationNameView(location: "Niko", date: "ПТ, 20 Июл", action: AnyView(EmptyView()))
        }
    }
}
