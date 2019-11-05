

const calcTotal = function() {
    total = Number($("#transaction_price")) * Number($("#transaction_number"))
    $('#transaction-fund-balance').text(`$${total}`)

}


const main = function() {
    $('#transaction_number').addEventListener("change", calcTotal)

}

$(document).ready(main())
