/*
MIT License

Copyright (c) 2017 MessageKit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit

open class AudioMessageView: UIView {

	// MARK: - Properties

	open let audioPlayerBackgroundColor = UIColor(red: 144.0/255.0, green: 224.0/255.0, blue: 149.0/255.0, alpha: 1.0)

	private var radius: CGFloat?

	let trackView = UIView(frame: CGRect(x: 64.0, y: 31.0, width: 206.0, height: 6.0))
	let positionView = UIView(frame: CGRect(x: 64.0, y: 26.67, width: 3.0, height: 14.0))
	let playBtn = UIButton(frame: CGRect(x: 11.0, y: 12.0, width: 42.0, height: 42.0))

	private lazy var playButtonImage: UIImage = {
		return UIImage(named: "play")!
	}()

	private lazy var pauseButtonImage: UIImage = {
		return UIImage(named: "pause")!
	}()


	// MARK: - Initializers
	override public init(frame: CGRect) {
		super.init(frame: frame)
		prepareView()
	}

	convenience public init() {
		self.init(frame: .zero)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Internal methods

	internal func prepareView() {
		backgroundColor = audioPlayerBackgroundColor
		contentMode = .scaleAspectFill
		layer.masksToBounds = true
		clipsToBounds = true

		trackView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
		trackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(trackView)

		positionView.backgroundColor = .white
		positionView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(positionView)

		playBtn.setImage(playButtonImage, for: .normal)
		playBtn.translatesAutoresizingMaskIntoConstraints = false
		addSubview(playBtn)

		setupConstraints()

		setCorner(radius: nil)
	}

	internal func setupConstraints() {

		let margins = self.layoutMarginsGuide

		// playBtn
		let playBtnWidth = playBtn.widthAnchor.constraint(equalToConstant: 42.0)
		let playBtnHeight = playBtn.heightAnchor.constraint(equalToConstant: 42.0)
		let playBtnCenterY = playBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		let playBtnLeading = playBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 11.0)
		NSLayoutConstraint.activate([playBtnWidth, playBtnHeight, playBtnCenterY, playBtnLeading])

		// trackView
		let trackViewLeading = trackView.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor, constant: 11.0)
		let trackViewTrailing = trackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -22.0)
		let trackViewCenterY = trackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		let trackViewHeight = trackView.heightAnchor.constraint(equalToConstant: 6.0)
		NSLayoutConstraint.activate([trackViewCenterY, trackViewHeight, trackViewLeading, trackViewTrailing])

		// positionView
		let positionViewWidth = positionView.widthAnchor.constraint(equalToConstant: 3.0)
		let positionViewHeight = positionView.heightAnchor.constraint(equalToConstant: 14.0)
		let positionViewCenterY = positionView.centerYAnchor.constraint(equalTo: trackView.centerYAnchor)
		let positionViewLeading = positionView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor, constant: 0.0)
		NSLayoutConstraint.activate([positionViewWidth, positionViewHeight, positionViewCenterY, positionViewLeading])

	}

	// MARK: - Open setters

	open func setCorner(radius: CGFloat?) {
		guard let radius = radius else {
			//if corner radius not set default to Circle
			let cornerRadius = min(frame.width, frame.height)
			layer.cornerRadius = cornerRadius/2
			return
		}
		self.radius = radius
		layer.cornerRadius = radius
	}

}
