var ss = 60

function counter(){

    if(ss>0){
        ss--
    } else {
        ss = 60
        priceValue.text = Update.getJson()
    }

    time.text = ss.toString() + ' s'
}

// Tendo em vista que a função setInterval() do JavaScript requer módulo externo, foi realizada a utilização da função nativa Timer do QML em conjunto com
// a função criada em JS que realiza a subtração do valor de segundos a cada segundo em que a função Timer aciona o trigger.
