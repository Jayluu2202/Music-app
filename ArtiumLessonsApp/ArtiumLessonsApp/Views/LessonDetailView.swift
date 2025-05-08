//
//  LessonDetailView.swift
//  ArtiumLessonsApp
//
//  Created by Admin on 07/05/25.
//

import SwiftUI
import AVKit

struct LessonDetailView: View {
    let lesson: Lesson
    @State private var showSubmitModal = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Title & Mentor (centered)
                VStack(spacing: 8) {
                    Text(lesson.lessonTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("by \(lesson.mentorName)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top)

                // Video player
                VideoPlayer(player: AVPlayer(url: URL(string: lesson.videoURL)!))
                    .frame(height: 220)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                // Lesson Notes
                VStack(alignment: .leading, spacing: 10) {
                    Text("Lesson Notes")
                        .font(.title)

                    Text("In this lesson, you'll learn the fundamental techniques of breath control for singing. Pay close attention to the video and try practicing with the exercises shown.")
                        .font(.body)
                        .foregroundColor(.black)
                }

                // Submit Button
                Button(action: {
                    showSubmitModal.toggle()
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Submit Practice")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                }
                .padding(.bottom)
            }
            .padding()
        }
        .background(Color.secondBg)
        .sheet(isPresented: $showSubmitModal) {
            SubmitPracticeModalView()
        }
    }
}



#Preview {
    LessonDetailView(lesson: Lesson(mentorName: "Arijit Singh",
                                    lessonTitle: "Breath Control Techniques",
                                    videoThumbnailURL: "https://images.pexels.com/photos/1587927/pexels-photo-1587927.jpeg",
                                    lessonImageURL: "https://images.pexels.com/photos/3771835/pexels-photo-3771835.jpeg",
                                    videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                                   ))
}
