from PyQt6.QtCore import QObject, pyqtSlot, pyqtSignal

class Backend(QObject):

    @pyqtSlot(str)
    def sayHello(self, name):
        print(f"Hello, {name} from Python!")

    @pyqtSlot(result=str)
    def getGreeting(self):
        return "這是來自 Python 的回應！"
