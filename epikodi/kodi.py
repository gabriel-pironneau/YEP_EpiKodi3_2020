from PyQt5.QtGui import QIcon, QFont, QPixmap
from PyQt5.QtCore import QDir, Qt, QUrl, QSize
from PyQt5.QtMultimediaWidgets import QVideoWidget
from PyQt5.QtMultimedia import *
from PyQt5.QtWidgets import (QApplication, QFileDialog, QHBoxLayout, QLabel,
        QPushButton, QLineEdit, QAction, QMenuBar, QDialog, QSizePolicy, QSlider, QStyle, QVBoxLayout, QWidget, QStatusBar)

class Form(QDialog):

    def __init__(self, parent=None):
        super(Form, self).__init__(parent)

        layout = QVBoxLayout()

        self.buttonVideo = QButtonV()
        btnSize = QSize(20, 20)
        self.buttonVideo.setFixedHeight(40)
        layout.addWidget(self.buttonVideo)
        self.buttonAudio = QButtonA()
        btnSize = QSize(20, 20)
        self.buttonAudio.setFixedHeight(40)
        layout.addWidget(self.buttonAudio)
        self.setLayout(layout)


class AudioPlayer(QWidget):

    def __init__(self, parent=None):
        super(AudioPlayer, self).__init__(parent)


        btnSize = QSize(10, 10)

        self.label = QLabel(self)

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




class VideoPlayer(QWidget):

    def __init__(self, parent=None):
        super().__init__(parent)

        self.mediaPlayer = QMediaPlayer(None, QMediaPlayer.VideoSurface)

        btnSize = QSize(16, 16)
        videoWidget = QVideoWidget()

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

class QButtonV(QWidget):
    def __init__(self, parent=None):
        super(QButtonV, self).__init__(parent)
        #supperQButton.__init__(self, parent)
        self.player = VideoPlayer()
        self.player.setWindowTitle("KodiVideo")
        self.player.resize(800, 600)
        self.button = QPushButton('Video', self)
        self.button.setFont(QFont("Noto Sans", 8))
        btnSize = QSize(10, 10)
        self.button.setIconSize(btnSize)
        self.name='me'
        self.button.clicked.connect(self.calluser)
    def calluser(self):
        self.player.show()

class QButtonA(QWidget):
    def __init__(self, parent=None):
        super(QButtonA, self).__init__(parent)
        #supperQButton.__init__(self, parent)
        self.player = AudioPlayer()
        self.player.setWindowTitle("KodiPic")
        self.player.resize(800, 600)
        self.button = QPushButton('Pictures', self)
        self.button.setFont(QFont("Noto Sans", 8))
        btnSize = QSize(10, 10)
        self.button.setIconSize(btnSize)
        self.name='me'
        self.button.clicked.connect(self.calluser)
    def calluser(self):
        self.player.show()

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)

    form = Form()
    form.resize(1920, 1080)
    form.show()


    sys.exit(app.exec_())
