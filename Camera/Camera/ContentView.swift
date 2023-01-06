//
//  ContentView.swift
//  Camera
//
//  Created by 清水健司 on 2023/01/04.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var photoPickerSelectedImage: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            /*
            Spacer()
            if let captureImage {
                Image(uiImage: captureImage)
                    .resizable()
                    .scaledToFit()
            }
            */
            Spacer()
            Button {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")
                    captureImage = nil
                    isShowSheet.toggle()
                } else {
                    print("カメラは利用できません")
                }
            } label: {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            .sheet(isPresented: $isShowSheet) {
                if let captureImage {
                    EffectView(isShowSheet: $isShowSheet, captureImage: captureImage)
                } else {
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }
            }
            PhotosPicker(selection: $photoPickerSelectedImage, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                Text("フォトライブラリーから選択する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .padding()
            }
            .onChange(of: photoPickerSelectedImage) { photosPickerItem in
                if let photosPickerItem {
                    photosPickerItem.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data {
                    captureImage = nil
                                captureImage = UIImage(data: data)
                            }
                        case .failure:
                            return
                        }
                    }
                }
            }
            
            /*
            if let captureImage,
               let shareImage = Image(uiImage: captureImage) {
                ShareLink(item: shareImage, subject: nil, message: nil,
                          preview: SharePreview("Photo", image: shareImage)) {
                    Text("SNSに投稿する")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .padding()
                }
            }
            */
        }
        .onChange(of: captureImage) { image in
            if let _ = image {
                isShowSheet.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
