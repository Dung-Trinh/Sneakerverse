//
//  YoutubeVideoPlayer.swift
//  SneakerApp
//
//  Created by Dung  on 17.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import AVKit
import WebKit


class YoutubeVideoPlayer{
    var webView: WKWebView
    
    init(videoID:String,webView: WKWebView) {
        self.webView = webView
        loadYoutube(videoID: videoID)
    }
    
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
    


}
