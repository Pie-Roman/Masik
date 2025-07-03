//
//  NoteListNetworkWorker.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

class NoteListNetworkWorker {

    static let shared = NoteListNetworkWorker()

    private let baseURL = "http://89.169.182.244:8080/notes" // замени на свой сервер при деплое

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    private let noteListNetworkMapper = NoteListNetworkMapper()
    private let noteNetworkMapper = NoteNetworkMapper()
    private let noteBodyNetworkMapper = NoteBodyNetworkMapper()

    func fetchAll() async throws -> NoteList {
        guard let url = URL(string: baseURL) else { return NoteList(items: []) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let listDto = try decoder.decode(NoteListNetworkDto.self, from: data)
        return try noteListNetworkMapper.map(dto: listDto)
    }

    func add(noteBody: NoteBody) async throws -> Note {
        guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
        let noteBodyDto = noteBodyNetworkMapper.map(model: noteBody)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(noteBodyDto)

        let (data, _) = try await URLSession.shared.data(for: request)

        let noteDto = try decoder.decode(NoteNetworkDto.self, from: data)
        return try noteNetworkMapper.map(dto: noteDto)
    }

    func delete(id: String) async throws {
        guard let url = URL(string: "\(baseURL)/\(id)") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResp = response as? HTTPURLResponse, httpResp.statusCode == 204 else {
            throw URLError(.badServerResponse)
        }
    }

    func updateIsDone(id: String, isDone: Bool) async throws -> Note? {
        guard let url = URL(string: "\(baseURL)/\(id)") else { throw URLError(.badURL) }
        let noteBodyDto = NoteBodyNetworkDto(
            title: nil,
            isDone: isDone
        )

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(noteBodyDto)

        let (data, _) = try await URLSession.shared.data(for: request)
        let noteDto = try? decoder.decode(NoteNetworkDto.self, from: data)
        return try? noteDto.map { try noteNetworkMapper.map(dto: $0) }
    }
}
