//
//  ContentView.swift
//  ImagePicker-SwiftUI
//
//  Created by Begüm Arıcı on 21.02.2025.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    var body: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
                Button(action: {
                    self.data = nil
                    self.selectedItems = []
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                        .padding(8)
                }
            }
            Spacer()
            PhotosPicker(selection: $selectedItems,
                         maxSelectionCount: 1,
                         matching: .images) {
                Text("Pick Photo")
                    .font(.system(size:20))
            }
             .onChange(of: selectedItems) { newValue in
                 guard let item = selectedItems.first else {
                     return
                 }
                 item.loadTransferable(type: Data.self) { result in
                     switch result {
                     case .success(let data):
                         if let data = data {
                             self.data = data
                             } else {
                                 print("Data is nil")
                             }
                         case .failure(let failure):
                             fatalError("\(failure)")
                         }
                     }
                 }
             }
        }
    }

#Preview {
    ContentView()
}
