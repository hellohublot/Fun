//
//  HTWebController.swift
//  Live
//
//  Created by hublot on 2019/1/29.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import HTSwiftPlaceholder

class HTWebController: UIViewController {
    
    static let imageJavaScript = """
        function imageResizeScript() {
            var width = this.offsetWidth;
            if (this.width >= 200) {
                this.style.width = '100%';
                this.width = '100%';
            }
        }
        var imageList = document.getElementsByTagName('img');
        for (var i = 0; i < imageList.length; i ++) {
            var image = imageList[i];
            if (image.complete) {
                imageResizeScript.call(image);
            } else {
                image.onload = imageResizeScript;
            }
        }
    """
    
    
    
    let openPageFunctionName = "window.winOcx.openPage"
    
    var openPageMessageName: String {
        return openPageFunctionName.components(separatedBy: ".").joined(separator: "_")
    }
    
    let openPageFunctionTypeName = "type"
    
    let openPageFunctionParameterName = "parameter"
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration.init()
        configuration.userContentController.add(self, name: openPageMessageName)
		let replaceMessageJavaScript = """
		\(openPageFunctionName) = function(type, parameter) {
		window.webkit.messageHandlers.\(openPageMessageName).postMessage({'\(openPageFunctionTypeName)': type, '\(openPageFunctionParameterName)': parameter});
		};
		"""
		configuration.userContentController.addUserScript(WKUserScript.init(source: "window.initdata = { token: '\(HTUserAuthManager.userToken)', ioswkwebviewtype: '1'}", injectionTime: .atDocumentStart, forMainFrameOnly: false))
		configuration.userContentController.addUserScript(WKUserScript.init(source: replaceMessageJavaScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
		configuration.userContentController.addUserScript(WKUserScript.init(source: type(of: self).imageJavaScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
        let webView = WKWebView.init(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.placeholderProvider = Placeholder.default
        return webView
    }()
    
    var initalizeUrl: URL?
    
    /*-------------------------------------/ init /-----------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataSource()
        initInterface()
    }
    
    func initDataSource() {
        
    }
    
    func initInterface() {
        navigationItem.title = "加载中..."
        view.addSubview(webView)
        webView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
        
        let placeholder = Placeholder.default
        placeholder.reloadNetworkHandler = { [weak self] in
            self?.loadInitalizeUrl()
        }
        webView.placeholderProvider = placeholder
        loadInitalizeUrl()
    }
    
    func loadInitalizeUrl() {
        if let initalizeUrl = initalizeUrl {
            webView.placeholderState = .firstRefresh
            webView.load(URLRequest.init(url: initalizeUrl))
        }
    }
    
    func naviveContextReponse() {

    }
    
    func contextNaviveResponse(_ type: String, _ parameter: [String: Any]) {
        switch type {
        case "room":
            let roomIdString = parameter["rid"] as? String ?? ""
            let detailController = HTLiveDetailController()
            detailController.roomIdString = roomIdString
            detailController.modalPresentationStyle = .fullScreen
            Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
        default:
            break
        }
    }
    
    /*-------------------------------------/ controller override /-----------------------------------*/
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
    }
    
}

extension HTWebController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.placeholderState = .firstRefresh
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.placeholderState = .none
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let messageBody = message.body as? [String: Any] ?? [String: Any]()
        let messageType = messageBody[openPageFunctionTypeName] as? String ?? ""
        let messageParameter = messageBody[openPageFunctionParameterName] as? [String: Any] ?? [String: Any]()
        contextNaviveResponse(messageType, messageParameter)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.title = ((webView.title?.count ?? 0) > 0) ? webView.title : "网页浏览"
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.webView(webView, didFail: navigation, withError: error)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if case .firstRefresh = webView.placeholderState {
            webView.placeholderState = .errorNetwork
        }
    }
    
}
