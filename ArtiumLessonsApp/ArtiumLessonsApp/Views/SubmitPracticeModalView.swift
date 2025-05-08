//
//  SubmitPracticeModalView.swift
//  ArtiumLessonsApp
//
//  Created by Admin on 07/05/25.
//

import SwiftUI

struct SubmitPracticeModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var uploadProgress: Double = 0
    @State private var uploadState: UploadState = .idle

    enum UploadState {
        case idle, uploading, success, failure
    }

    var body: some View {
        ZStack {
            Color("Third Bg")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Submit Practice")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                
                switch uploadState {
                case .idle:
                    Button(action: {
                        startUpload()
                    }) {
                        Text("Upload File")
                            .foregroundStyle(.white)
                    }
                case .uploading:
                    ProgressView(value: uploadProgress)
                    Text("Uploading...")
                        .foregroundStyle(Color.white)
                case .success:
                    Text("Upload successful! ✅")
                        .foregroundStyle(Color.white)
                case .failure:
                    Text("Upload failed ❌")
                        .foregroundStyle(Color.white)
                    Button(action: {
                        startUpload()
                    }) {
                        Text("Retry")
                            .foregroundStyle(Color.white)
                    }
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .foregroundColor(.black)
                }

            }
            .padding()
        }
    }
 

    func startUpload() {
        uploadState = .uploading
        uploadProgress = 0

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            uploadProgress += 0.1
            if uploadProgress >= 1 {
                timer.invalidate()
                uploadState = Bool.random() ? .success : .failure
            }
        }
    }
}


#Preview {
    SubmitPracticeModalView()
}
