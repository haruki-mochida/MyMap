//
//  ContentView.swift
//  MyMap
//
//  Created by 持田晴生 on 2023/04/20.
//

import SwiftUI

struct ContentView: View {
    //入力中の文字列を保持する状態変数
    @State var inputText: String = ""
    // 検索キーワードを保持する状態変数
    @State var displaySearchKey:String = ""
    
    var body: some View {
        //垂直にレイアウト(縦方向にレイアウト)
        VStack{
            //テキストフィールド（文字入力）
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
            //入力が官僚されたとき
                .onSubmit {
                    displaySearchKey = inputText
                }
            //余白を追加
                .padding()
            
            //マップを表示
            MapView(searchKey: displaySearchKey)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
