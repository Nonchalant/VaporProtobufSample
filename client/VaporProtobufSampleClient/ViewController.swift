//
//  ViewController.swift
//  VaporProtobufSampleClient
//
//  Created by Ihara Takeshi on 2018/01/02.
//  Copyright © 2018 Takeshi Ihara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    private var response: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var urlRequest = URLRequest(url: URL(string: "http://localhost:9000/user")!)

        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/protobuf"
        ]

        request(with: urlRequest) {
            self.response = try! UserResponse(serializedData: $0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return response?.users.count ?? 0
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = response?.users[indexPath.row].name
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let req = UserRequest.with {
            $0.name = UUID().uuidString
        }

        var urlRequest = URLRequest(url: URL(string: "http://localhost:9000/user")!)

        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/protobuf"
        ]

        urlRequest.httpBody = try! req.serializedData()
        urlRequest.httpMethod = "POST"
        request(with: urlRequest) {
            self.response = try! UserResponse(serializedData: $0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func request(with request: URLRequest, _ completion: ((Data) -> Void)? = nil) {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                return
            }

            completion?(data)
        }.resume()
    }
}
