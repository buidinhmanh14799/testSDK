import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: MyWebView!
    var urlString: String = urlDefault
    
    private var titleString: String = "Daiichi"
    
    var onClose: (() -> Void)?
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var pageTitleObservation: NSKeyValueObservation?
    
    init(urlString: String, onClose: (() -> Void)?) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        self.onClose = onClose
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        pageTitleObservation?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _setUpWebView()
        _setUpUI()
        
        
        let myRequest = URLRequest(url: URL(string:urlString)!)
        webView.load(myRequest)
        
        pageTitleObservation = webView.observe(\.title, options: [.new]) { [weak self] webView, change in
            if let newTitle = change.newValue {
                self?.titleLabel.text = (newTitle ?? "").replacingOccurrences(of: "- Dai-ichi Life Việt Nam", with: "").replacingOccurrences(of: "Homepage", with: "")
            }
        }
    }
    
    private func _setUpWebView(){
        webView = MyWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.bounces = false
    }
    
    private func _setUpUI(){
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        
        view.addSubview(navigationBar)
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        print("okok\(view.safeAreaInsets.top)")
        
        navigationBar.addSubview(closeButton)
        navigationBar.addSubview(reloadButton)
        navigationBar.addSubview(titleLabel)
        navigationBar.addSubview(urlLabel)
        
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.top + 40).isActive = true
        
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        closeButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive=true
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive=true
        closeButton.addTarget(self, action: #selector(onPressClose), for: .touchUpInside)
        

        reloadButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16).isActive = true
        reloadButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 24).isActive=true
        reloadButton.widthAnchor.constraint(equalToConstant: 24).isActive=true
        reloadButton.addTarget(self, action: #selector(onPressReload), for: .touchUpInside)
        
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        titleLabel.text = titleString

        
//        urlLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 50).isActive = true
//        urlLabel.text = urlString
        

    }
    
    @objc func onPressClose(){
        
        if onClose != nil {
            onClose!()
        } else {
            if webView.canGoBack {
                webView.goBack()
            } else {
                self.dismiss(animated: true)
            }
        }

    }
    
    @objc func onPressReload(){
        activityIndicator.startAnimating()
        webView.reload()
    }
    
    let navigationBar: UIView = {
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 85)
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.686, green: 0.224, blue: 0.239, alpha: 1).cgColor,
            UIColor(red: 0.886, green: 0.38, blue: 0.255, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]

        layer0.startPoint = CGPoint(x: 0.5, y: 1)
        layer0.endPoint = CGPoint(x: 0.5, y: 0)

        layer0.bounds = view.bounds
        layer0.position = view.center
        
        view.layer.addSublayer(layer0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let closeIcon = UIImage(named: "backImage", in: Bundle.module, compatibleWith: nil)
        button.setImage(closeIcon, for: .normal)
        return button
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let reloadIcon = UIImage(named: "reloadImage", in: Bundle.module, compatibleWith: nil)
        
        button.setImage(reloadIcon, for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20))
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Mulish-Bold", size: 16)
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urlLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 18))
        label.font = UIFont(name: "Mulish-Regular", size: 10)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.549, green: 0.561, blue: 0.624, alpha: 1)
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    func onCloseWebView() {

    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        
    }


    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Xử lý lỗi tải trang web nếu cần
    }
    
    
    
}

