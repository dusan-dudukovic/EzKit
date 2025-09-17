//
//  ThreadSafeBool.swift
//  EzKit
//
//  Created by Dusan Dudukovic on 17. 9. 2025..
//

import Foundation

public class ThreadSafeBool {
    private var value: Bool = false
    private let queue = DispatchQueue(label: "com.ezkit.threadsafebool.concurrentQueue", qos: .userInteractive, attributes: .concurrent)

    init(_ value: Bool) {
        self.value = value
    }
    
    // Safe Write using `.barrier`
    func set(_ value: Bool) {
        queue.async(flags: .barrier) { [weak self] in
            self?.value = value
        }
    }

    // Safe Read using `.sync`
    func get() -> Bool {
        return queue.sync { [weak self] in
            self?.value ?? false
        }
    }

}
