//
//  SearchSectionView.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import SwiftUI

struct Constants {
    static let headlineText = "Enter your topic to search"
    static let textFieldPlaceholder = "Enter Topic"
    static let buttonText = "Search"
    static let descriptionText = "Total number of times that topic string appears is:"
    static let alertTitleText = "Empty Topic"
    static let alertMessageText = "Please enter a topic before fetching data."
    static let alertButtonText = "OK"
}

struct SearchSectionView: View {
    
    //MARK:- Properties
    @ObservedObject var viewModel: WikipediaViewModel
    @Binding var showAlert: Bool
    @State private var isSearching: Bool = false
    
    //MARK:- Body
    var body: some View {
        VStack(spacing: 0) {
            Text(Constants.headlineText)
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            
            Group {
                TextField(Constants.textFieldPlaceholder, text: $viewModel.topic)
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
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text(Constants.alertTitleText), message: Text(Constants.alertMessageText), dismissButton: .default(Text(Constants.alertButtonText)))
        }
    }
}

private extension SearchSectionView {
    
    func searchButtonView() -> some View {
        Button(action: {
            handleSearchButtonTapped()
        }) {
            HStack {
                Text(Constants.buttonText)
                if isSearching {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.trailing, 5)
                }
            }
        }
        .buttonStyle(SearchButtonStyle())
        .accessibilityIdentifier("searchButton")
    }
    
    func handleSearchButtonTapped() {
        isSearching = true
        hideKeyboard()

        guard !viewModel.topic.isEmpty else {
            isSearching = false
            showAlert = true
            return
        }
        
        viewModel.fetchTopicCount(for: viewModel.topic) { _ in
            isSearching = false
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
