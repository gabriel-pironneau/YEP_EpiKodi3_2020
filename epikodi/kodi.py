from PyQt5.QtGui import QIcon, QFont, QPixmap
from PyQt5.QtCore import QDir, Qt, QUrl, QSize
from PyQt5.QtMultimediaWidgets import QVideoWidget
from PyQt5.QtMultimedia import *
from PyQt5.QtWidgets import (QApplication, QFileDialog, QHBoxLayout, QLabel,
        QPushButton, QLineEdit, QAction, QMenuBar, QDialog, QSizePolicy, QSlider, QStyle, QVBoxLayout, QWidget, QStatusBar)
import cv2, pafy
import numpy as np
import easygui

class Form(QDialog):

    def __init__(self, parent=None):
        super(Form, self).__init__(parent)

        layout = QVBoxLayout()
        btnSize = QSize(10, 10)


        self.buttonV = QPushButton('Video', self)
        self.buttonV.setFont(QFont("Noto Sans", 8))
        self.buttonV.setIconSize(btnSize)
        self.buttonV.clicked.connect(self.showV)
        layout.addWidget(self.buttonV)

        self.buttonB = QPushButton('Pictures', self)
        self.buttonB.setFont(QFont("Noto Sans", 8))
        self.buttonB.setIconSize(btnSize)
        self.buttonB.clicked.connect(self.showB)
        layout.addWidget(self.buttonB)


        ##layout.addWidget(self.buttonAudio)
        self.edit = QLineEdit("Your youtube link here")
        layout.addWidget(self.edit)
        self.button = QPushButton("read video yt")
        self.button.setFont(QFont("Noto Sans", 8))
        self.button.clicked.connect(self.Read)
        layout.addWidget(self.button)
        self.setLayout(layout)

    def Read(self):
        try:
            url = self.edit.text()
            vPafy = pafy.new(url)
            play = vPafy.getbest()

            cap = cv2.VideoCapture(play.url)
            while (True):
                ret,frame = cap.read()

                cv2.imshow('youtube',frame)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break

            cap.release()
            cv2.destroyAllWindows()
        except:
            easygui.msgbox("this is not a valid link", title="An arror happened")

    def showV(self):
        self.hide()
        self.player = VideoPlayer()
        self.player.setWindowTitle("KodiVideo")
        self.player.resize(1920, 1000)
        self.player.show()

    def showB(self):
        self.hide()
        self.player = Pictures()
        self.player.setWindowTitle("KodiPic")
        self.player.resize(1920, 1000)
        self.player.show()


class Pictures(QDialog):

    def __init__(self, parent=None):
        super(Pictures, self).__init__(parent)


        btnSize = QSize(10, 10)

        self.label = QLabel(self)


        ButtonV = QPushButton("Vidéo")
        ButtonV.setFixedHeight(24)
        ButtonV.setIconSize(btnSize)
        ButtonV.setFont(QFont("Noto Sans", 8))
        ButtonV.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        ButtonV.clicked.connect(self.navV)

        ButtonB = QPushButton("Main page")
        ButtonB.setFixedHeight(24)
        ButtonB.setIconSize(btnSize)
        ButtonB.setFont(QFont("Noto Sans", 8))
        ButtonB.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        ButtonB.clicked.connect(self.navB)

        openButton = QPushButton("Open picture")
        openButton.setToolTip("Open picture File")
        openButton.setStatusTip("Open picture File")
        openButton.setFixedHeight(24)
        openButton.setIconSize(btnSize)
        openButton.setFont(QFont("Noto Sans", 8))
        openButton.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        openButton.clicked.connect(self.abrir)


        controlLayout = QHBoxLayout()
        controlLayout.setContentsMargins(0, 0, 0, 0)
        controlLayout.addWidget(ButtonB)
        controlLayout.addWidget(ButtonV)
        controlLayout.addWidget(openButton)


        self.layout = QVBoxLayout()
        self.layout.addLayout(controlLayout)

        self.setLayout(self.layout)


    def abrir(self):
        fileName, _ = QFileDialog.getOpenFileName(self, "Select pic",
                ".", "Pictures Files (*.jpg *.jpeg *.png)")

        if fileName != '':
            pixmap = QPixmap(fileName)
            self.label.setPixmap(pixmap)
            self.layout.addWidget(self.label)
            self.resize(pixmap.width(), pixmap.height())

    def navV(self):
        self.hide()
        self.form = VideoPlayer()
        self.form.resize(1920, 1000)
        self.form.show()

    def navB(self):
        self.hide()
        self.form = Form()
        self.form.resize(1920, 1000)
        self.form.show()


class VideoPlayer(QDialog):

    def __init__(self, parent=None):
        super().__init__(parent)

        geometry = app.desktop().availableGeometry()
        geometry.setHeight(geometry.height())

        self.setGeometry(geometry)

        self.mediaPlayer = QMediaPlayer(None, QMediaPlayer.VideoSurface)

        btnSize = QSize(16, 16)
        videoWidget = QVideoWidget()

        ButtonP = QPushButton("Pictures")
        ButtonP.setFixedHeight(24)
        ButtonP.setIconSize(btnSize)
        ButtonP.setFont(QFont("Noto Sans", 8))
        ButtonP.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        ButtonP.clicked.connect(self.navP)

        ButtonB = QPushButton("Main page")
        ButtonB.setFixedHeight(24)
        ButtonB.setIconSize(btnSize)
        ButtonB.setFont(QFont("Noto Sans", 8))
        ButtonB.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        ButtonB.clicked.connect(self.navB)

        openButton = QPushButton("Open Video")
        openButton.setToolTip("Open Video File")
        openButton.setStatusTip("Open Video File")
        openButton.setFixedHeight(24)
        openButton.setIconSize(btnSize)
        openButton.setFont(QFont("Noto Sans", 8))
        openButton.setIcon(QIcon.fromTheme("document-open", QIcon("D:/_Qt/img/open.png")))
        openButton.clicked.connect(self.abrir)

        self.playButton = QPushButton()
        self.playButton.setEnabled(False)
        self.playButton.setFixedHeight(24)
        self.playButton.setIconSize(btnSize)
        self.playButton.setIcon(self.style().standardIcon(QStyle.SP_MediaPlay))
        self.playButton.clicked.connect(self.play)

        self.positionSlider = QSlider(Qt.Horizontal)
        self.positionSlider.setRange(0, 0)
        self.positionSlider.sliderMoved.connect(self.setPosition)

        self.statusBar = QStatusBar()
        self.statusBar.setFont(QFont("Noto Sans", 7))
        self.statusBar.setFixedHeight(14)

        controlLayout = QHBoxLayout()
        controlLayout.setContentsMargins(0, 0, 0, 0)
        controlLayout.addWidget(openButton)
        controlLayout.addWidget(self.playButton)
        controlLayout.addWidget(self.positionSlider)

        layout = QVBoxLayout()
        controlLayout.addWidget(ButtonB)
        controlLayout.addWidget(ButtonP)
        layout.addWidget(videoWidget)
        layout.addLayout(controlLayout)
        layout.addWidget(self.statusBar)

        self.setLayout(layout)

        self.mediaPlayer.setVideoOutput(videoWidget)
        self.mediaPlayer.stateChanged.connect(self.mediaStateChanged)
        self.mediaPlayer.positionChanged.connect(self.positionChanged)
        self.mediaPlayer.durationChanged.connect(self.durationChanged)
        self.mediaPlayer.error.connect(self.handleError)
        self.statusBar.showMessage("Ready")

    def abrir(self):
        fileName, _ = QFileDialog.getOpenFileName(self, "Select vidéo",
                ".", "Video Files (*.mp4 *.mp3 *.flv *.ts *.mts *.avi)")

        if fileName != '':
            self.mediaPlayer.setMedia(
                    QMediaContent(QUrl.fromLocalFile(fileName)))
            self.playButton.setEnabled(True)
            self.statusBar.showMessage(fileName)
            self.play()

    def navP(self):
        self.hide()
        self.form = Pictures()
        self.form.resize(1920, 1000)
        self.form.show()

    def navB(self):
        self.hide()
        self.form = Form()
        self.form.resize(1920, 1000)
        self.form.show()

    def play(self):
        if self.mediaPlayer.state() == QMediaPlayer.PlayingState:
            self.mediaPlayer.pause()
        else:
            self.mediaPlayer.play()

    def mediaStateChanged(self, state):
        if self.mediaPlayer.state() == QMediaPlayer.PlayingState:
            self.playButton.setIcon(
                    self.style().standardIcon(QStyle.SP_MediaPause))
        else:
            self.playButton.setIcon(
                    self.style().standardIcon(QStyle.SP_MediaPlay))

    def positionChanged(self, position):
        self.positionSlider.setValue(position)

    def durationChanged(self, duration):
        self.positionSlider.setRange(0, duration)

    def setPosition(self, position):
        self.mediaPlayer.setPosition(position)

    def handleError(self):
        self.playButton.setEnabled(False)
        self.statusBar.showMessage("Error: " + self.mediaPlayer.errorString())


class QButtonC(QWidget):
    def __init__(self, parent=None):
        super(QButtonC, self).__init__(parent)
        #supperQButton.__init__(self, parent)
        self.player = Form()
        self.player.setWindowTitle("mainWindow")
        self.player.resize(1920, 1000)
        self.layout = QVBoxLayout()
        self.edit = QLineEdit("name")
        self.layout.addWidget(self.edit)
        self.edit2 = QLineEdit("pass")
        self.layout.addWidget(self.edit2)
        self.button = QPushButton('connection', self)
        self.button.setFont(QFont("Noto Sans", 8))
        btnSize = QSize(10, 10)
        self.button.setIconSize(btnSize)
        self.name='me'
        self.button.clicked.connect(self.calluser)
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)

    def calluser(self):
        self.hide()
        self.player.show()

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    form = QButtonC()
    form.setWindowTitle("connection page")
    form.resize(800, 600)
    form.show()

    sys.exit(app.exec_())
