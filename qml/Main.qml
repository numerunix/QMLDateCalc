/*
 * Copyright (C) 2022  Giulio Sorrentino
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * qmldatecalc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


MainView {
    applicationName: 'qmldatecalc'
    automaticOrientation: true
    width: units.gu(45)
    height: units.gu(75)
    AdaptivePageLayout {
        anchors.fill: parent
        primaryPage: page1
        Page {
                id: page1
        	header: PageHeader {
        	    title: 'qmldatecalc'
        	}
            Settings {
    	id: "settings"
    	property string data: "2022-12-25"
    }
    Image {
    	    id: background
            source: "../assets/Background.jpg"
            width: parent.width
            height: parent.height
    }	
    ColumnLayout{
    	   anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
    	   width: parent.width
	   height: page1.contentHeight   	   

       	   Label {
	        text: i18n.tr("Insert the date")
	        color: "white"
	        Layout.fillWidth: true
	   }
	
           DatePicker {
        	id: datePicker
        	date: settings.value("data", "2022-12-25")
        	minimum: new Date( Qt.formatDate("2022-01-01", "yyyy-MM-dd"))
	        Layout.fillWidth: true
           }
       	   Button {
            	text: i18n.tr("Calculate");
            	onClicked: {
            		var actual = new Date( Qt.formatDate(datePicker.date, "yyyy-MM-dd"));
            		var now= new Date();
            		var data=actual.getTime()-now;
            	        data=Math.floor(data / (1000 * 3600 * 24));
            		result.text=i18n.tr("There are ") +data+ i18n.tr(" days left.");
            		settings.setValue("data", datePicker.date);
            		settings.sync;
            	}
	        Layout.fillWidth: true
    	  }
    	  Label {
    	  	id: result
    	  	text: qsTr("");
	        color: "white"
	        Layout.fillWidth: true
    	  }
                Button {
                    text: i18n.tr("Informations")
                    onClicked: page1.pageStack.addPageToCurrentColumn(page1, page2)
                }
            }
        }
        Page {
	            id: page2
            header: PageHeader {
        	    title: i18n.tr('Informations')
        }
    Image {
            source: "../assets/Background.jpg"
            width: parent.width
            height: parent.height
    }	
            ColumnLayout {
	    anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
    	   width: parent.width
	   height: page2.contentHeight   	   
            Label {
    	  	text: qsTr("© 2022 Giulio Sorrentino")
	        color: "black"
	        Layout.fillWidth: true
    	  }
    	  Label {
    	  	text: qsTr("Sotto licenza GPL v3 o, secondo la tua opinione, qualsiasi\nversione successiva.")
	        color: "white"
	        Layout.fillWidth: true
	  }
	  Label {
	  	text: qsTr("Pagina del progetto:\nhttps://github.com/numerunix/qmldatecalc")
	        color: "white"
	        Layout.fillWidth: true
	  }
	  }
    	  
      }
   }
}

