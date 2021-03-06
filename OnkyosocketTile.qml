import QtWebSockets 1.1
import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Tile {
	id: onkyosocketTile
	property bool dimState: screenStateController.dimmedColors



	NewTextLabel {
		id: powerButton
		width: isNxt ? 284 : 220;  
		height: isNxt ? 35 : 30
		buttonActiveColor: "grey"
		buttonHoverColor: "blue"
		enabled : true
		textColor : "black"
		textDisabledColor : "grey"
		buttonText: !app.actPower ? "Power On": "Power Off"
		anchors {
			top: parent.top
			topMargin: 1
			horizontalCenter: parent.horizontalCenter 
			}
		onClicked: !app.actPower ? app.sendwebsock("PWR01")  : app.sendwebsock("PWR00")
		visible: !dimState
	}
		

	Rectangle {
		id: itemText
		color:  "transparent"
		width: powerButton.width; height: isNxt ? 53 : 42
		Text{
			id: iText
			width: parent.width
			font.pixelSize: ((app.actualTitleLong||!dimState) && !isNxt)? 12 : 20
			wrapMode: Text.WordWrap
         		text: !app.actFM ? app.actualArtist : "Radio Preset: " + app.actualPreset;
			font.family: qfont.regular.name
			font.bold: true
			color: !dimState? "black" : "white"
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter 
     		}
		anchors {
			top: powerButton.bottom
			topMargin: 1
			left: powerButton.left
            	}
		MouseArea{
			id: buttonMouseArea198
			anchors.fill: parent 
			onClicked: {stage.openFullscreen(app.onkyosocketScreenUrl);}
		}
	}


	Rectangle {
		id: titleText
		color: "transparent"
		width: powerButton.width; height: isNxt ? 53 : 42     		
		Text{
			id: tText
			width: parent.width
			font.pixelSize: ((app.actualTitleLong||!dimState) && !isNxt)? 12 : 20 
			wrapMode: Text.WordWrap
         		text: app.actualTitle
			font.family: qfont.regular.name
			font.bold: true
			color: !dimState? "black" : "white"
     		}
		anchors {
			top: itemText.bottom
			topMargin: 2
			left: powerButton.left		
		}
		MouseArea{
			id: buttonMouseArea199
			anchors.fill: parent 
			onClicked: {stage.openFullscreen(app.onkyosocketScreenUrl);}
		}
	}


	//volume control session start here, first you'll find the first button.
	IconButton {
		id: volumeDown
		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			left: parent.left
			leftMargin:  isNxt ? 6 : 2  		
		}
		iconSource: "qrc:/tsc/volume_down_small.png"
		onClicked: {app.sendwebsock("MVLDOWN1");}
		visible: !dimState && app.actPower
	}

	IconButton {
		id: prevButton
		anchors {
			left: volumeDown.right
			leftMargin:  isNxt ? 3 : 2 
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/left.png"
		onClicked: {app.sendwebsock("NTCTRDN");}		
		visible: !dimState && app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)
	}

	IconButton {
		id: playButton
		anchors {
			left: prevButton.right
			leftMargin:  isNxt ? 3 : 2 
			bottom: parent.bottom
			bottomMargin: 5
		}

		iconSource: "qrc:/tsc/play.png"
		onClicked: {app.sendwebsock("NTCPAUSE");}
		visible: !dimState && app.actPower && (app.actBT || app.actAirplay || app.actNET)	
	}

	IconButton {
		id: shuffleOnButton
		anchors {
			left: playButton.right
			leftMargin:  isNxt ? 3 : 2 
			bottom: parent.bottom
			bottomMargin: 5
		}
		iconSource: "qrc:/tsc/shuffle.png"
		onClicked: {
			app.shuffleButtonVisible = false;
			app.shuffleOnButtonVisible = false;
			app.sendwebsock("NTCRANDOM");}
		visible: !dimState && app.actPower && (app.actBT || app.actAirplay || app.actNET)
	}
		
	IconButton {
		id: nextButton
		anchors {
			left: shuffleOnButton.right
			leftMargin:  isNxt ? 3 : 2 
			bottom: parent.bottom
			bottomMargin: 5
		}
		iconSource: "qrc:/tsc/right.png"
		onClicked: {app.sendwebsock("NTCTRUP");}
		visible: !dimState && app.actPower && (app.actBT || app.actAirplay || app.actNET || app.actFM)	
	}	
	
	IconButton {
		id: volumeUp
		anchors {
			left: nextButton.right
			leftMargin: isNxt ? 3 : 2
			bottom: parent.bottom
			bottomMargin: 5
		}
		iconSource: "qrc:/tsc/volume_up_small.png"
		onClicked: {app.sendwebsock("MVLUP1");}
		visible: !dimState && app.actPower
	}

}