//
//  WebViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/03/2023.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
}

//https://blog.devgenius.io/embedded-youtube-videos-in-swiftui-900d3a0e80d4
// https://blog.devgenius.io/webviews-in-swiftui-d5b1229e37ba
