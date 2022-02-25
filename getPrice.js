function getJson() { // Realiza a requisição GET na API da NOXBITCOIN a fim de receber os valores desejados
    var http = new XMLHttpRequest();
    var url = "https://app.noxbitcoin.com.br/api/tickers/price";
    var price

    http.onreadystatechange=function() {

        if (http.readyState === XMLHttpRequest.DONE && http.status == 200) {
            price = JSON.parse(http.responseText)
            var ticker_ask = price["ticker"]["ask"];
            var ticker_bid = price ["ticker"]["bid"];
            var bitcoin = ((ticker_ask+ticker_bid)/2).toLocaleString(Qt.locale("pt_BR")) //Armazena a média aritmética entre os valores de [ticker][ask] e [ticker][bid]
            priceValue.text = `R$ ${bitcoin}`
            alert.visible = false //retira da tela o alerta de excesso de limite de request GET, caso tenha sido apresentado na tela
            message.visible = false

        } else if (http.status == 429) { //Tendo em vista a regra de consulta à API, de limitação de consulta a cada 30s, quando a regra for "quebrada" é ativado o alerta criado
            alert.visible = true
            message.visible = true
        }

    }
    http.open("GET", url, true);
    http.send();
}
