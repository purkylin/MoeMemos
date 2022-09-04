//
//  MemosList.swift
//  MoeMemos
//
//  Created by Mudkip on 2022/9/4.
//

import SwiftUI

struct MemosList: View {
    @State private var searchString = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(Memo.samples, id: \.id) { memo in
                Section {
                    MemoCard(memo)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            ZStack {
                Button {
                    
                } label: {
                    ZStack {
                        Circle()
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }.frame(width: 60, height: 60)
                }
            }.padding(20)
        }
        .searchable(text: $searchString)
        .navigationTitle("Memos")
    }
}

struct MemosList_Previews: PreviewProvider {
    static var previews: some View {
        MemosList()
    }
}
