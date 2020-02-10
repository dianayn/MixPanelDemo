//
//  ViewController.swift
//  MixpanelDemo
//
//  Created by Diana Duan on 8/2/20.
//  Copyright © 2020 diana. All rights reserved.
//

import UIKit
import Mixpanel

class ViewController: UIViewController {

    private let counterLable = UILabel()

    var counter = 60
    var timer = Timer()

    // what is the different between loadView()  and ViewDidLoad()
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 120
        view.addSubview(stackView)

        let secondStackView = UIStackView()
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.axis = .vertical
        secondStackView.spacing = 15
        view.addSubview(secondStackView)
        secondStackView.addSubview(counterLable)

        counterLable.text = "Lable"
        counterLable.font = UIFont.preferredFont(forTextStyle: .headline)
        counterLable.font = UIFont.boldSystemFont(ofSize: 20)
        counterLable.textColor = .darkText
        counterLable.textAlignment = .center

        let startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.systemBlue, for: .normal)
        startButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startClick), for: .touchUpInside)

        let stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.systemBlue, for: .normal)
        stopButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        stopButton.backgroundColor = .white
        stopButton.layer.cornerRadius = 10
        stopButton.addTarget(self, action: #selector(stopClick), for: .touchUpInside)

        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(stopButton)
        secondStackView.addArrangedSubview(counterLable)

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            stopButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),

            secondStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            secondStackView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

        ])

        self.view = view

    }

    override func viewDidLoad() {

        super.viewDidLoad()

        counterLable.text = String(counter)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func startClick(_sender: Any) {

        if timer.isValid {
            timer.invalidate()
        }

        counter = 60
        counterLable.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)

        // Track Event
        Mixpanel.mainInstance().time(event: "Timer Started")
    }

    @objc func stopClick(_sender: Any) {
        timer.invalidate()

        // Track Event
        Mixpanel.mainInstance().track(event: "Timer Stopped", properties: ["Counter": counterLable.text!])
    }

    @objc func countdown() {
        if(counter > 0) {
            counter -= 1
            counterLable.text = String(counter)
        }
        else {
            timer.invalidate()
        }
    }

}

