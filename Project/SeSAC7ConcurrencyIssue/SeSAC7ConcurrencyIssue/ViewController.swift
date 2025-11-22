//
//  ViewController.swift
//  SeSAC7ConcurrencyIssue
//
//  Created by 서준일 on 11/19/25.
//

import UIKit

final class ViewController: UIViewController {
    
    var nickname: String = "고래밥"
    
    private let nicknameLock: NSLock = NSLock()
    private let nicknameSemaphore = DispatchSemaphore(value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        datarace()
//        mutex()
//        semaphore()
        deadLock()
    }
    
    func deadLock() {
        let lockA = NSLock()
        let lockB = NSLock()

        // Thread 1
        DispatchQueue.global().async {
            lockA.lock()
            print("Thread 1: lockA 획득")
            Thread.sleep(forTimeInterval: 0.1)
            
            lockB.lock()  // ❌ Thread 2가 lockB를 들고 있어서 대기
            print("Thread 1: lockB 획득")
            
            lockB.unlock()
            lockA.unlock()
        }

        // Thread 2
        DispatchQueue.global().async {
            lockB.lock()
            print("Thread 2: lockB 획득")
            Thread.sleep(forTimeInterval: 0.1)
            
            lockA.lock()  // ❌ Thread 1이 lockA를 들고 있어서 대기
            print("Thread 2: lockA 획득")
            
            lockA.unlock()
            lockB.unlock()
        }
    }
    
    func semaphore() {
        
        self.nicknameLock.lock()
        print(">> ", nickname)
        self.nicknameLock.unlock()
        
        DispatchQueue.global().async {
            
            self.nicknameSemaphore.wait()
            self.nickname = "틱촉"
            self.nicknameSemaphore.signal()
        }
        
        DispatchQueue.global().async {
            
            self.nicknameSemaphore.wait()
            self.nickname = "카스타드"
            self.nicknameSemaphore.signal()
        }
        
        self.nicknameSemaphore.wait()
        print(">>>> ", nickname)
        self.nicknameSemaphore.signal()
        
        Thread.sleep(forTimeInterval: 1)
        
        self.nicknameSemaphore.wait()
        print(">>>>>>: ", nickname)
        self.nicknameSemaphore.signal()
    }
    
    func mutex() {
        
        self.nicknameLock.lock()
        print(">> ", nickname)
        self.nicknameLock.unlock()
        
        DispatchQueue.global().async {
            
            self.nicknameLock.lock()
            self.nickname = "칙촉"
            self.nicknameLock.unlock()
            
        }
        
        DispatchQueue.global().async {

            self.nicknameLock.lock()
            self.nickname = "카스타드"
            self.nicknameLock.unlock()
        }
        
        self.nicknameLock.lock()
        print(">>>> ", nickname)
        self.nicknameLock.unlock()
        
        Thread.sleep(forTimeInterval: 1)
        
        self.nicknameLock.lock()
        print(">>>>>>: ", nickname)
        self.nicknameLock.unlock()
        
        Thread.sleep(forTimeInterval: 1)
        
        self.nicknameLock.lock()
        print(">>>>>>>>: ", nickname)
        self.nicknameLock.unlock()

    }


    func datarace() {
        
        print(">> ", nickname)
        
        DispatchQueue.global().async {
            
            self.nickname = "틱촉"
        }
        
        DispatchQueue.global().async {
            
            self.nickname = "카스타드"
        }
        
        print(">>>> ", nickname)
    }
    
}

