//
//  ViewController.swift
//  DownloadImageSampleProject
//
//  Created by 주혁 on 2023/02/25.
//

import UIKit

class ViewController: UIViewController {

    private var imageLoadTableView: UITableView!
    private var loadAllImagesButton: UIButton!

    let downloadImageService: DownLoadImageServiceType = DownloadImageService()
    var imageURLList: [String] = [] {
        didSet {
            imageLoadTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchImageList()
    }

    private func configureUI() {
        loadAllImagesButton = {
            let button = UIButton(type: .custom)
            button.backgroundColor = .systemBlue
            button.setTitle("Load All Images", for: .normal)
            button.addTarget(self, action: #selector(loadAllImagesDidTap), for: .touchUpInside)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            return button
        }()

        imageLoadTableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(LoadImageTableViewCell.self, forCellReuseIdentifier: LoadImageTableViewCell.identifier)
            return tableView
        }()

        view.addSubview(loadAllImagesButton)
        loadAllImagesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadAllImagesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loadAllImagesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loadAllImagesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadAllImagesButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(imageLoadTableView)
        imageLoadTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLoadTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageLoadTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageLoadTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageLoadTableView.bottomAnchor.constraint(equalTo: loadAllImagesButton.topAnchor)
        ])
    }

    private func fetchImageList() {
        imageURLList = downloadImageService.fetchImageURLList()
    }

    @objc func loadAllImagesDidTap() {
        for cell in imageLoadTableView.visibleCells {
            guard let cell = cell as? LoadImageTableViewCell else { return }
            cell.loadImage()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadImageTableViewCell.identifier, for: indexPath) as? LoadImageTableViewCell
        else { return UITableViewCell() }
        cell.downLoadImageService = downloadImageService
        cell.loadImageURLString = imageURLList[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

