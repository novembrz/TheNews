//
//  SourceViewController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

protocol SourceDelegate: class {
    func updateSource(source: SourceModel)
}

class SourceViewController: UIViewController {

    private var viewModel: SourceViewModelType!
    weak var delegate: SourceDelegate?

    private var tableView = UITableView()
    private var newSourceButton: UIBarButtonItem!

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "У Вас нет источников новостей\n Добавьте их, нажав на плюс!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "avenir", size: 24)
        label.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SourceViewModel()
        viewModel?.loadSources()
        viewModel?.setIsCurrent()
        
        setupTableView()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    private func setupNavigationBar() {
        newSourceButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createAlert))

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationItem.title = "Источники"
        navigationItem.rightBarButtonItem = newSourceButton
    }

    private func setupTableView() {

        view.addSubview(tableView)
        tableView.addSubview(warningLabel)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.pin(view: view)
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.reuseId)

        NSLayoutConstraint.activate([
            warningLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            warningLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100),
            warningLabel.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -30),
            warningLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 30)
        ])
    }

    //MARK:- Create Alert

        @objc private func createAlert(){

            let alert = UIAlertController(title: "Создайте новый источник", message: "", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Назад", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { saveAction -> Void in

                guard let titleTextField = alert.textFields?[0],
                      let urlTextField = alert.textFields?[1] else { return }

                guard let titleText = titleTextField.text, let urlText = urlTextField.text else { return }

                let newSource = SourceModel(title: titleText, url: urlText, isCurrent: true)
                self.viewModel?.refreshIsCurrent()
                self.viewModel.sources.append(newSource)
                self.tableView.reloadData()
                self.delegate?.updateSource(source: newSource)
                self.viewModel?.saveSourcesInUserDefaults()

                titleTextField.text = ""
                urlTextField.text = ""
                saveAction.isEnabled = true
            })

            saveAction.isEnabled = false

            alert.addTextField { (tf) in
                tf.placeholder = "Введите название источника"
                tf.delegate = self
                tf.addTarget(alert, action: #selector(alert.textDidChangeAlert), for: .editingChanged)
            }

            alert.addTextField { (tf) in
                tf.placeholder = "Введите url-адрес"
                tf.delegate = self
                tf.addTarget(alert, action: #selector(alert.textDidChangeAlert), for: .editingChanged)
            }

            alert.addAction(cancelAction)
            alert.addAction(saveAction)

            present(alert, animated: true, completion: nil)
        }
}


//MARK: UITableView Delegate DataSource

extension SourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.sources.count == 0{
            tableView.separatorStyle = .none
            warningLabel.isHidden = false
        } else {
            warningLabel.isHidden = true
        }
        return viewModel.sources.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as? NewsFeedCell
        else { return UITableViewCell() }
        
        let source = viewModel.sources[indexPath.row]
        cell.titleLabel.text = source.title
        cell.dateLabel.text = source.url
        cell.accessoryType = source.isCurrent ? .checkmark : .none
        cell.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        return cell
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserDefaultManager.clearUserData()
            self.viewModel?.sources.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
          }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        for i in 0..<viewModel!.sources.count {
            viewModel!.sources[i].isCurrent = false
        }
        
        viewModel!.currentSource = viewModel!.sources[indexPath.row]
        viewModel!.sources[indexPath.row].isCurrent = true
        
        tableView.reloadData()
        
        guard let newSource = viewModel?.currentSource else { return }
        self.delegate?.updateSource(source: newSource)
    }
}


//MARK: UITextFieldDelegate

extension SourceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


