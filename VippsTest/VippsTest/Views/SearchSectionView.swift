//
//  SearchSectionView.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import SwiftUI

struct SearchSectionView: View {
    
    @State var topicT: String
    struct Constants {
        static let headlineText = "Enter your topic to search"
        static let textFieldPlaceholder = "Enter Topic"
        static let buttonText = "Search"
        static let descriptionText = "Total number of times that topic string appears is:"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(Constants.headlineText)
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            
            Group {
                TextField(Constants.textFieldPlaceholder, text: $topicT)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityIdentifier("searchTextField")
                
                searchButtonView()
            }
            .padding(.horizontal)
            
            Text(Constants.descriptionText)
                .font(.title3)
                .padding(.top)
                .padding([.leading, .trailing], 16)
                .frame(minWidth: 300, minHeight: 0, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Color.black.opacity(0.7))
    }
}

struct SearchSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSectionView(topicT: "test")
    }
}

private extension SearchSectionView {
    
    private func searchButtonView() -> some View {
        Button(action: {
            print("Tapped")
            handleSearchButtonTapped()
        }) {
            Text(Constants.buttonText)
            // is Searching
        }
        .buttonStyle(SearchButtonStyle())
        .accessibilityIdentifier("searchButton")
    }
    
    func handleSearchButtonTapped() {
        
    }
}

// Search Button Style
private struct SearchButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 44, alignment: .center)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}
