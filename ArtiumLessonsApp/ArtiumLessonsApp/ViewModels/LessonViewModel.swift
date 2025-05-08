//
//  LessonViewModel.swift
//  ArtiumLessonsApp
//
//  Created by Admin on 07/05/25.
//

import Foundation

class LessonViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchLessons() {
        guard let url = URL(string: "https://www.jsonkeeper.com/b/QKKI") else {
            self.errorMessage = "Invalid URL"
            return
        }
        

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(LessonsResponse.self, from: data)
                    self.lessons = decoded.lessons
                } catch {
                    self.errorMessage = "JSON decoding failed: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
