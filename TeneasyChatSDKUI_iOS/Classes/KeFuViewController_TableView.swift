
extension KeFuViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datasouceArray[indexPath.row]
        if model.isLeft {
            if model.cellType == CellType.TYPE_QA {
                let cell = BWChatQuestionCell.cell(tableView: tableView)
                cell.model = model
                cell.consultId = Int32(self.consultId)
                cell.heightBlock = { [weak self] (height: Double) in
                    self?.questionViewHeight = height + 30
                    self?.tableView.reloadData()
                }
                cell.clickBlock = { [weak self] (model: QA) in
                    self?.sendMsg(textMsg: model.question?.content?.data ?? "")

                    let msg = self?.lib.composeALocalMessage(textMsg: model.content ?? "")
                    if msg != nil {
                        self?.appendDataSource(msg: msg!, isLeft: true)
                    }
                }
                return cell
            }
            let cell = BWChatLeftCell.cell(tableView: tableView)
            cell.model = model
            return cell
        }
        let cell = BWChatRightCell.cell(tableView: tableView)
        cell.model = model
        cell.resendBlock = { [weak self] _ in
            self?.datasouceArray[indexPath.row].sendStatus = .发送中
            self?.lib.resendMsg(msg: model.message, payloadId: model.payLoadId)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasouceArray.count
    }

//    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = datasouceArray[indexPath.row]
        if model.cellType == CellType.TYPE_QA {
            return questionViewHeight
        }
        if model.message.image.uri.isEmpty == false {
            return 200.0
        }
        return 50.0
    }
}
