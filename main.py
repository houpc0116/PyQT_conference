import sys
import os
from PyQt6.QtWidgets import QApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QUrl
from backend import Backend


# 設定 QML 使用 Material 樣式
os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()

# 建立後端物件並註冊到 QML
backend = Backend()
engine.rootContext().setContextProperty("backend", backend)

# 載入 QML UI
engine.load(QUrl.fromLocalFile("main.qml"))

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
