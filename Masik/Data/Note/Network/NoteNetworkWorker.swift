//
//  NoteListNetworkWorker.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

class NoteNetworkWorker {

    static let shared = NoteNetworkWorker()

    private let baseURL = "http://89.169.182.244:8080/notes"

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
    private let noteTagNetworkMapper = NoteTagNetworkMapper()

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
    
    func update(id: String, noteBody: NoteBody) async throws -> Note {
        guard let url = URL(string: "\(baseURL)/\(id)") else { throw URLError(.badURL) }
        let noteBodyDto = noteBodyNetworkMapper.map(model: noteBody)

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(noteBodyDto)

        let (data, _) = try await URLSession.shared.data(for: request)
        let noteDto = try decoder.decode(NoteNetworkDto.self, from: data)
        return try noteNetworkMapper.map(dto: noteDto)
    }
    
    func fetchAllTags() async throws -> [NoteTag] {
        guard let url = URL(string: "\(baseURL)/tags") else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        let listDto = try decoder.decode([NoteTagNetworkDto].self, from: data)
        return try listDto.map(noteTagNetworkMapper.map)
    }
    
    func addTag(tag: NoteTag) async throws -> NoteTag {
        guard let url = URL(string: "\(baseURL)/tags") else { throw URLError(.badURL) }
        let noteTagDto = noteTagNetworkMapper.map(model: tag)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(noteTagDto)

        let (data, _) = try await URLSession.shared.data(for: request)

        let addedNoteTagDto = try decoder.decode(NoteTagNetworkDto.self, from: data)
        return try noteTagNetworkMapper.map(dto: addedNoteTagDto)
    }
}
