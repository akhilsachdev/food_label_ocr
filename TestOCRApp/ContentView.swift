//
//  ContentView.swift
//  TestOCRApp
//
//  Created by Akhil Sachdev on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showScanner = false
    @State private var texts: [ScanData] = []
    
    var body: some View {
        NavigationView {
            VStack{
                if texts.count > 0 {
                    List {
                        ForEach(texts) {text in
                            NavigationLink(destination: ScrollView{Text(text.content)}, label: {Text(text.content).lineLimit(1)})
                        }
                    }
                } else {
                    Text("No Scans yet").font(.title)
                }
            }
                .navigationTitle("Scanned Food Labels")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {self.showScanner = true}, label: {Image(systemName: "doc.text.viewfinder")})
                    }
                }

                .sheet(isPresented: self.$showScanner, content: {
                    makeScannerView()
                })
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScanner = false
        })
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
