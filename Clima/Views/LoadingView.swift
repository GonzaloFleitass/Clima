//
//  LoadingView.swift
//  Clima
//
//  Created by Gonzalo Fleitas on 21/7/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth:.infinity, maxHeight:.infinity)
    }
}

#Preview {
    LoadingView()
}
