//
//  AppStorageView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("TapCount \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    AppStorageView()
}
