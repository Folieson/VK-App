//
//  LoginFormController.swift
//  VK App
//
//  Created by Андрей Понамарчук on 16.09.2018.
//  Copyright © 2018 Андрей Понамарчук. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        /*
        // Получаем текст логина
        let login = loginInput.text!
        
        // Получаем текст-пароль
        let password = passwordInput.text!
        
        // Проверяем, верны ли они
        if login == "admin" && password == "123456" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Присваиваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification:Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении кдавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // Второе - когда оно пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Отписываемся от уведомлений
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Метод скрытия клавиатуры
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // Проверка логина и пароля перед срабатыванием segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверка данных
        let checkResult = checkUserData()
        
        // Показываем ошибку, если данные неверны
        if !checkResult {
            showLoginError()
        }
        
        // Возвращаем результат проверки
        return checkResult
    }
    
    func checkUserData() -> Bool {
        // Получаем текст логина
        let login = loginInput.text!
        
        // Получаем текст-пароль
        let password = passwordInput.text!
        
        // Проверяем, верны ли они
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
        
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }

    

}
