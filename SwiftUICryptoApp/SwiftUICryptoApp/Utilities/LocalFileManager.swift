//
//  LocalFileManager.swift
//  SwiftUICryptoApp
//
//  Created by Viktor Drykin on 27.08.2024.
//

import SwiftUI

class LocalFileManager {

    static let instance = LocalFileManager()

    private init() { }

    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)

        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }

        do {
            try data.write(to: url)
        } catch {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path(percentEncoded: true))
        else {
            return nil
        }
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory. FolderName:\(folderName). \(error)")
            }
        }
    }

    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
    }

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appending(path: imageName + ".png")
    }
}
