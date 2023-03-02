//
//  LoadImageTableViewCell.swift
//  DownloadImageSampleProject
//
//  Created by 주혁 on 2023/02/26.
//

import UIKit

class LoadImageTableViewCell: UITableViewCell {

    static let identifier = "LoadImageTableViewCell"

    var loadImageView: UIImageView!
    var loadProgressBar: UIProgressView!
    var loadButton: UIButton!

    var downLoadImageService: DownLoadImageServiceType!
    var loadImageURLString: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }

    func configureUI() {
        configureLoadImageView()
        configureLoadButton()
        configureLoadProgressBar()
    }

    private func configureLoadImageView() {
        loadImageView = UIImageView(image: UIImage(systemName: "person.crop.square"))
        loadImageView.contentMode = .scaleAspectFit
        contentView.addSubview(loadImageView)
        loadImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            loadImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            loadImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            loadImageView.widthAnchor.constraint(equalTo: loadImageView.heightAnchor, multiplier: 2.0),
            loadImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureLoadButton() {
        loadButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Load", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.addTarget(self, action: #selector(loadButtonDidTap(sender:)), for: .touchUpInside)
            return button
        }()

        contentView.addSubview(loadButton)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            loadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            loadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            loadButton.widthAnchor.constraint(equalTo: loadButton.heightAnchor, multiplier: 2.0)
        ])
        loadButton.layer.cornerRadius = 10
        loadButton.layer.masksToBounds = true
    }

    private func configureLoadProgressBar() {
        loadProgressBar = UIProgressView(progressViewStyle: .default)
        contentView.addSubview(loadProgressBar)
        loadProgressBar.translatesAutoresizingMaskIntoConstraints = false
        loadProgressBar.progress = 0
        NSLayoutConstraint.activate([
            loadProgressBar.leadingAnchor.constraint(equalTo: loadImageView.trailingAnchor, constant: 10),
            loadProgressBar.trailingAnchor.constraint(equalTo: loadButton.leadingAnchor, constant: -10),
            loadProgressBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @IBAction func loadButtonDidTap(sender: UIButton) {
        loadImage()
    }

    func loadImage() {
        loadImageView.image = nil
        self.loadProgressBar.progress = 0
        Task {
            let image = try? await fetchImage()
            loadImageView.image = image
            self.loadProgressBar.progress = 1.0
        }
    }

    private func fetchImage() async throws -> UIImage? {
        guard let loadImageURLString else { return nil }
        return try await downLoadImageService.loadImage(imageURL: loadImageURLString) { progressRate in
            print("completion")
        }
    }
}
