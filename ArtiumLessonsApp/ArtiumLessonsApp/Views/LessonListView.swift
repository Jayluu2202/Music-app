//
//  LessonListView.swift
//  ArtiumLessonsApp
//
//  Created by Admin on 07/05/25.
//

import SwiftUI

struct LessonListView: View {
    @StateObject private var viewModel = LessonViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading lessons...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.lessons) { lesson in
                            NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                LessonCardView(lesson: lesson)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .background(Color.firstBg)
            .foregroundStyle(Color.white)
            .navigationTitle("Music Lessons")
   
        }
        .onAppear{
            UINavigationBar.appearance().tintColor = .white
            viewModel.fetchLessons()
        }
    }
}

struct LessonCardView: View {
    let lesson: Lesson

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            AsyncImage(url: URL(string: lesson.videoThumbnailURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Color.red
                        .overlay(Image(systemName: "exclamationmark.triangle").foregroundColor(.white))
                } else {
                    Color.gray.opacity(0.7)
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()


            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.2)]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .clipped()


            VStack(alignment: .leading, spacing: 4) {
                Text(lesson.lessonTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Mentor: \(lesson.mentorName)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
    }
}



#Preview {
    LessonListView()
}
