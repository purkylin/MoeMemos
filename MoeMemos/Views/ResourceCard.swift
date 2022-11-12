//
//  ResourceCard.swift
//  MoeMemos
//
//  Created by Mudkip on 2022/9/11.
//

import SwiftUI

struct ResourceCard: View {
    let resource: Resource
    let resourceManager: ResourceManager
    
    init(resource: Resource, resourceManager: ResourceManager) {
        self.resource = resource
        self.resourceManager = resourceManager
    }
    
    @EnvironmentObject private var memosViewModel: MemosViewModel
    @EnvironmentObject private var memosManager: MemosManager
    @State private var imagePreviewURL: URL?

    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                if let url = url(for: resource) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .onTapGesture {
                        imagePreviewURL = url
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contextMenu {
                menu(for: resource)
            }
            .fullScreenCover(item: $imagePreviewURL) { url in
                if let url = url {
                    ImageViewer(imageURL: url)
                }
            }
    }
    
    @ViewBuilder
    func menu(for resource: Resource) -> some View {
        Button(role: .destructive, action: {
            Task {
                try await resourceManager.deleteResource(id: resource.id)
            }
        }, label: {
            Label("Delete", systemImage: "trash")
        })
    }
    
    private func url(for resource: Resource) -> URL? {
        memosManager.hostURL?
            .appendingPathComponent("/o/r")
            .appendingPathComponent("\(resource.id)")
            .appendingPathComponent(resource.filename)
    }
}

struct ResourceCard_Previews: PreviewProvider {
    static var previews: some View {
        ResourceCard(resource: Resource(id: 1, createdTs: .now, creatorId: 0, filename: "", size: 0, type: "image/jpeg", updatedTs: .now), resourceManager: ResourceListViewModel())
            .environmentObject(MemosViewModel())
            .environmentObject(MemosManager())
    }
}