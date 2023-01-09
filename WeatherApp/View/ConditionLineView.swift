//
//  ConditionLineView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 05.01.2023.
//

import SwiftUI

enum ConditionType {
    
    case humidity
    case wind(String)
    case temp
    
    var image: String {
        switch self {
        case .temp: return "temp"
        case .humidity: return "humidity"
        case .wind: return "wind"
        }
    }
}

struct ConditionLineView: View {
    var condition: ConditionType
    var value: String
    
    var body: some View {
        conditionLine()
    }
    
    private func conditionLine() -> some View {
        HStack {
            Image(condition.image)
                .resizable()
                .scaledToFit()
                .frame(width: 20.0, height: 20.0)
            switch condition {
            case .temp: Text(value)
            }
            
                .foregroundColor(.mainWhite)
                .font(.system(size: 20))
            if case .wind(let direction) = condition {
                Image(direction)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
            }
        }
    }
}

//struct ConditionLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConditionLineView()
//    }
//}
