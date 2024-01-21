//
//  WikipediaSearchHomeView.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import SwiftUI

struct WikipediaSearchHomeView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 16) {
                // Heading
                headerView()
                    .padding(.top, 32)
                    .fixedSize()
                
                Image("wikipedia-logo")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                // Search Section
                SearchSectionView(topicT: "xyz")

                // Result Section
                resultTextView()
                Spacer()

            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            .background(Color.orange.opacity(0.5))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaSearchHomeView()
    }
}

private extension WikipediaSearchHomeView {
    func headerView() -> some View {
        Text("Wikipedia")
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80)
    }
    
    func resultTextView() -> some View {
        Text("1")
            .font(.largeTitle)
            .padding(.top)
            .foregroundColor( true ? .green : .red)
    }
}
