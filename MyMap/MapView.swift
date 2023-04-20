//
//  MapView.swift
//  MyMap
//
//  Created by 持田晴生 on 2023/04/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    //検索キーワード
    let searchKey: String
    //表示するViewを作成するときに実行
    func makeUIView(context: Context) -> MKMapView {
        //MKMapViewのインスタンス生成
        MKMapView()
    }//makeUIView　ここまで
    
    //表示した　View　が更新されるたびに実行
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //入力された文字をデバックエリアに表示
        print("検索キーワード:\(searchKey)")
        
        //CLGeocoderインスタンスを生成
        let geocoder = CLGeocoder()
        
        //入力された文字から位置情報を取得
        geocoder.geocodeAddressString(
            searchKey,
            completionHandler: { (placemarks, error) in
                //リクエストの結果が存在し、1件目の情報から位置情報を取り出す
                if let placemarks,
                   let firstPlacemarks = placemarks.first,
                   let location = firstPlacemarks.location{
                    
                    //位置情報から緯度経度をtargetCoordinateに取り出す
                    let targetCoordinate = location.coordinate
                    
                    //緯度経度をデバックエリアに表示
                    print("緯度経度:\(targetCoordinate)")
                    
                    //MKPointAnnotation()インスタンスを生成し、ピンを作る
                    let pin = MKPointAnnotation()
                    
                    //ピンを置く場所に緯度経度を設定
                    pin.coordinate = targetCoordinate
                    
                    //ピンのタイトルを設定
                    pin.title = searchKey
                    
                    //ピンを地図に置く
                    uiView.addAnnotation(pin)
                    
                    //緯度経度を中心に半径500mの範囲を表示
                    uiView.region = MKCoordinateRegion(
                        center:targetCoordinate,
                        latitudinalMeters: 500.0,
                        longitudinalMeters: 500.0)
                    
                }//ifここまで
                
            })//geocoderここまで
        
    }//updateUIViewここまで
    
}// MapView　ここまで

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "羽田空港")
    }
}
