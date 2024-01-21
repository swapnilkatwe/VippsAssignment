//
//  WikipediaSearchHomeView.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import SwiftUI

struct WikipediaSearchHomeView: View {
    
    //MARK:- Properties
    @StateObject var viewModel = WikipediaViewModel()
    @State private var showAlert = false

    //MARK:- Body
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
                SearchSectionView(viewModel: viewModel, showAlert: $showAlert)

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

private extension WikipediaSearchHomeView {
    func headerView() -> some View {
        Text("Wikipedia")
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80)
    }
    
    func resultTextView() -> some View {
        Text("\(viewModel.count)")
            .font(.largeTitle)
            .padding(.top)
            .foregroundColor( (viewModel.count != 0) ? .green : .red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaSearchHomeView()
    }
}
