
const calcTotal = function() {
    let total = Number($("#transaction_price").val()) * Number($("#transaction_number").val())
    $('#transaction_total').text(`Total: $${total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')}`)
    return total
}


const button = () => {
    let total = Number($("#transaction_price").val()) * Number($("#transaction_number").val())
    let fund = parseFloat($('#transaction_fund').text().slice(7).replace(/[^0-9.-]+/g,""))
    let onHand = Number($('#transaction_share_on_hand').text().slice(15))
    let number = Number($("#transaction_number").val())

    if (total > fund && $('#transaction_trade_type').val() === "Buy") {
        $('.transaction_button').hide();
        $('#transaction_msg').text(`Insufficient Fund!`).css('color', 'red')
        $('form.new_transaction').attr('action', '')
    }
    else if (total <= fund && $('#transaction_trade_type').val() === "Buy") {
        $('.transaction_button').show()
        $('#transaction_msg').text(``).css('color', 'red')

        $('form.new_transaction').attr('action', '/transactions')
    }
    else if (number > onHand && $('#transaction_trade_type').val() === "Sell") {
        $('.transaction_button').hide()
        $('#transaction_msg').text(`You don't have enough share!`).css('color', 'red')
        $('form.new_transaction').attr('action', '')
    }
    else if (number <= onHand && $('#transaction_trade_type').val() === "Sell") {
        $('.transaction_button').show()
        $('#transaction_msg').text(``).css('color', 'red')

        $('form.new_transaction').attr('action', '/transactions')
    }
}

const figureColor = () => {
    $('.figure').each(()=>{
        let text = $(this).text()
        if (Number(text) >= 0) {
            $(this).css('color', 'green')
        } else {
            $(this).css('color', 'red')
        }
    })
}

const changeAction = () => {
    $('.search-form').attr('action', `/watchlists/${$('#nav-search-input').val()}`)
}

const main = function() {
    $('#transaction_number, #transaction_trade_type').on("change", ()=>{calcTotal(); button()})

    $('#nav-search-input').on('change', changeAction())

    $('#trade_link').click(()=>{$('#trade_form').toggle()})


    figureColor()
}


$(document).ready(main)
