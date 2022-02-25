import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "getPrice.js" as Update
import "counterUpdate.js" as Counter

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: qsTr("Nox App")
    color: "#242429"

    //Última versão do QT (6) não possui módulo QTQuick.Dialogs, sendo necessária a criação de um MessageAlert
    //com recursos nativos. A mensagem de alerta desaparece da interface quando a requisição GET é devidamente
    //realizada, sem o erro de requisição por excesso do limite

    Rectangle {
        id: alert
        width: 280
        height: 50
        x: parent.width/2 - width/2
        y: 450
        visible: false
        color: "white"
        radius: 40
        opacity: 0.5
    }
    Text {
        id: message
        text: qsTr("<b>AGUARDE ALGUNS SEGUNDOS</b><br>A atualização de preço<br> só pode ocorrer a cada 30 segundos.")
        anchors.centerIn: alert
        font.family: "Montserrat"
        anchors.horizontalCenter: alert.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        padding: 5

    }

    //Layout em coluna, tendo em vista que todos os elementos do projeto são posicionados verticalmente
    Column {
        id: column
        width: root.width
        height: root.height
        anchors.fill: parent


        Image {
            id: logo
            source: "/images/noxbran.png"
            width: 90
            fillMode: Image.PreserveAspectFit
            x: column.width/2 - width/2
            anchors.top: column.top
            anchors.topMargin: 30

        }

        // 1º Elemento do Layout: Preço Atualizado do Bitcoin
        Column {
            id: bitPrice
            x: column.width/2 - width/2
            anchors.top: logo.bottom
            anchors.topMargin: 45
            spacing: 10
            Component.onCompleted: priceValue.text = Update.getJson()

            Label {

                id: priceValue
                color: "#C4C4C4"
                font.family: "Montserrat"
                font.pointSize: 22
                anchors.horizontalCenter: parent.horizontalCenter
            }


            Label {
                id: priceTag
                text: qsTr("PREÇO DO BITCOIN AGORA")
                color: "#C4C4C4"
                font.family: "Montserrat"
                anchors.horizontalCenter: parent.horizontalCenter

            }
        }

        // 2º Elemento do Layout: Contador regressivo para atualização automática a cada 60 segundos
        // Utilizado método nativo do QML (Timer) a fim de fazer a call da função do contador a cada segundo (função é chamada no arquivo "counterUpdate.js"
        Column {
            id: updateCounter
            x: column.width/2 - width/2
            anchors.top: bitPrice.bottom
            anchors.topMargin: 80
            spacing: 10


            Text {
                id: updateTitle
                text: qsTr("Preço será atualizado em")
                color: "#C4C4C4"
                font.family: "Montserrat"
                font.pointSize: 10
                anchors.horizontalCenter: parent.horizontalCenter

            }


            Rectangle {
                id: counterBox
                color: "#FDE000"
                radius: 40
                width: 120
                height: 25
                anchors.horizontalCenter: parent.horizontalCenter



                Label {
                    id: time
                    anchors.centerIn: parent
                    font.family: "Montserrat"
                    font.pointSize: 9

                    Timer{
                        interval: 1000; running:true; repeat: true; triggeredOnStart: true
                        onTriggered: Counter.counter()
                    }
                }

            }


        }

        // 3º Elemento: Botão para atualização instantânea realizando a call imediata da função de getJson do arquivo JS "getPrice"
        // Este botão possui eficiência limitada às regras de requisições da API, tendo em vista que esta permite a requisição GET apenas a cada 30 segundos
        // Por esse motivo, ainda que não fazia parte do projeto, foi criado o Alerta ao topo do código, a fim de evitar que o usuário (que não tem contato com o backend)
        // tenha a informação de que deve aguardar para realizar nova requisição.
        Rectangle {
            id: updateButton
            radius: 40
            gradient:
                Gradient {
                GradientStop { position: 0.0; color: "#ffe764" }
                GradientStop { position: 0.5; color: "#fed540" }
                GradientStop { position: 1.0; color: "#fece2e" }
                orientation: Gradient.Horizontal
            }
            width: 280
            height: 40
            x: column.width/2 - width/2
            anchors.bottom: column.bottom
            anchors.bottomMargin: 20
            Text {
                text: qsTr("ATUALIZAR AGORA")
                anchors.centerIn: parent
                font.family: "Montserrat"
            }
            MouseArea{
                id: mouse
                anchors.fill: parent
                onClicked: priceValue.text = Update.getJson()
                HoverHandler{
                    cursorShape: "PointingHandCursor"

                }

            }
        }


    }

}

