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

        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 120
        hStackView.distribution = .fillEqually
//        view.addSubview(stackView)

        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 50
        view.addSubview(vStackView)
        // secondStackView.addSubview(counterLable Vs secondStackView.addArrangedSubview(counterLable)

        // For starckView, better use `addArrangedSubview`
        // arrangedSubview is array, display is in the index order
        vStackView.addArrangedSubview(counterLable)
        vStackView.addArrangedSubview(hStackView)

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

        hStackView.addArrangedSubview(startButton)
        hStackView.addArrangedSubview(stopButton)

        NSLayoutConstraint.activate([
//            define contraint for main stackview
//            based on design, decide the contraints for UI in the stackview(container), or the screen
            hStackView.widthAnchor.constraint(equalToConstant: 300),
            vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // instance variable
        // self , in this case, inside instance func of class, it refers to the instance of the class
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

